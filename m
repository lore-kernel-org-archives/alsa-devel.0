From: terminator356@users.sourceforge.net
Subject: multi pcm and mmap problem
Date: Wed, 21 Nov 2007 01:58:41 -0500
Message-ID: <200711210158.42108.terminator356@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.rog.mail.re2.yahoo.com (smtp104.rog.mail.re2.yahoo.com
	[206.190.36.82]) by alsa0.perex.cz (Postfix) with SMTP id C9FAE247D6
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 07:44:21 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

After 2 years I've finally traced and fixed a problem
 which was preventing me from using anything after 
 ALSA 1.0.9b !

In ALSA lib 1.0.9b: 
pcm/pcm_generic.c:
int snd_pcm_generic_channel_info()
{
        snd_pcm_generic_t *generic = pcm->private_data;
                return snd_pcm_channel_info(generic->slave, info);
}

But in ALSA lib 1.0.15: 
pcm/pcm_generic.c:
int snd_pcm_generic_channel_info()
{
        snd_pcm_generic_t *generic = pcm->private_data;
        if (pcm->mmap_shadow) {
                /* No own buffer is required - the plugin won't change
                 * the data on the buffer, or do safely on-the-place
                 * conversion
                 */
                return snd_pcm_channel_info(generic->slave, info);
        } else {
               // Tim: TESTED: This is now called instead of the other one!
                /* Allocate own buffer */
                return snd_pcm_channel_info_shm(pcm, info, -1);
        }
}

My multi PCM consists of a plughw:0,2 and a hw:1,0
In ALSA 1.0.9b, all five PCMs ALSA creates for this arrangement
 create their areas with mmap(). And it works.
But in ALSA 1.0.15 my hw:1,0 and its multi PCM areas are
 created with mmap(), and my plughw:0,2 and its PCMs areas 
 are created with malloc(). 
Can't hear/record any sound from the plughw:0,2 part of the multi.

I have verified that ALSA 1.0.15 is copying the plughw:0,2 HW PCM 
 areas to its LINEAR PCM areas, but NOT finally to its multi PCM areas.
It just copies all zeros. 
That's the reason I hear/record no sound from the plughw:0,2 part
 of the multi PCM.
So I reverted the function's code back to 1.0.9b and presto!
It works now, the same as in ALSA 1.0.9b 

So please tell me, am I missing something?
Should I add something more to my .asoundrc ?
I see that besides {type multi ... }, there is a {type share ...} defined. 
*** Does the 'share' have any use here? Can't find any docs on it.

Also:
Yes, I can see now, why you made this code change.
mmap() has limits, so you switched over to malloc().
Those limits force the user to use small buffers
 and/or reduce the number of channels created.
Otherwise aplay, arecord, and jack etc complain mmap() failed.
In ALSA 1.0.9b, and after my change to ALSA 1.0.15,
 I tried ulimit() -l, and editing /etc/security/limits.conf
I quadrupled the available locked memory, but aplay, arecord etc
 still won't let me increase the buffer size beyond what it
 was BEFORE I edited limits.conf
*** What am I doing wrong?

Thanks
Tim.
