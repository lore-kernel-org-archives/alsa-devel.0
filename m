From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [INFO] C-Media CMI9761 -A- type , CODEC ID
Date: Thu, 17 Feb 2005 02:27:34 +0100
Message-ID: <4213F306.50802@gmx.de>
References: <4212D866.5000304@gmx.de> <s5hk6p8bx3v.wl@alsa2.suse.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hk6p8bx3v.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 16 Feb 2005 06:21:42 +0100,
> thomas schorpp wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: RIPEMD160
>>
>>hello,
>>
>>this device
>>
>>http://www.cmedia.com.tw/product/CMI9761.htm
>>
>>the -A- type ive got
>>
>>has working continuous (slider) master mixer+balance and "working" pcm
>>mixer slider with v106 (2.6.10 release kernel alsa) but no more with
>>v108 alsa-driver or cvs from yesterday.
>>
>>please branch for this device (on cheap asrock mass-seller K7VTA+ board
>>with via8235 pci).
> 
> 
> Interesting.  How can one detect the difference of model?  Does it
> have a different codec id?
> 

uh-oh!

{ 0x434d4941, 0xffffffff, "CMI9738",		patch_cm9738,	NULL },
{ 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },
{ 0x434d4978, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
{ 0x434d4982, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
/* { 0x434d4983, 0xffffffff, "CMI9761",		patch_cm9761,	NULL }, */
{ 0x434d4983, 0xffffffff, "CMI9761A",		patch_cm9761a,	NULL },


Feb 17 02:05:42 tom1 kernel: ALSA 
/usr/src/alsa/alsa-driver/alsa-kernel/pci/ac97/ac97_patch.c:2105: AC'97 
0 is [0x434d4983] id.

can it be?

or im mistaking here:

int patch_cm9761a(ac97_t *ac97)
{
	snd_printk(KERN_ERR "AC'97 %d is [0x%x] id.\n", ac97->num, ac97->id); 
/*identify schorpp s -A- chip*/

ive seen you somewhere in the code branching by mainboard vendor.

	/* Special exception for ASUS W1000/CMI9739. It does not have an SPDIF 
in. */
	if (ac97->pci &&
	     ac97->subsystem_vendor == 0x1043 &&
	     ac97->subsystem_device == 0x1843) {


well see...

tom

> 
> Takashi
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
