From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Question on sequencer synth driver
Date: Fri, 10 May 2002 05:06:10 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020510050610.C8147@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

I'm still struggling with my MikMod driver, and since no one has answered 
my previous mails, I've been trying to figure it out myself. Maybe I'm in
Jaroslav's procmailrc or something :( Takashi can you take a look?

My problem is that events get delivered but I don't get any sound. I've
concluded that snd_gus_synth_event_input() get's called and it in turn
calls snd_gus_sample_event(). And in that function the problem arises. The
for-loop tests for v->use for each voice. And in my case v->use is never
set. The 'use' field is set in snd_gf1_alloc_voice() which is called from
snd_gus_synth_use(). Is's called for as many voices as the subscriber has
requested. But the voices field in snd_seq_port_subscribe_t can't be set
because there is no function to do so. So I think I need 
snd_seq_port_subscribe_set_voices(). To continue my testing I added that
function to my local copy of alsa-lib. But I was disappointed again. Now
it seems that snd_gus_synth_use() doesn't even get called when I
connect my client to the synth. It's registered as the 'use' port
callback, and if I'm not mistaken it should get called whenever a client
connects.

Summary:
I think snd_subscribe_{set,get}_voices() are needed.
Why doesn't snd_gus_synth_use() get called when my client connects to it?


The latest verions of the MikMod driver is at
"http://www.saunalahti.fi/~syrjala/alsa/"

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
