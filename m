From: "Bo Henriksen" <bo.henriksen@nordicid.com>
Subject: RE: snd_pcm_lib_preallocate_pages_for_all
Date: Mon, 5 Jul 2004 13:57:22 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <A6991F0FA073F34C94E97976CAC0323116F8E5@server2.nordicid.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The simplest solution is to disable mmap on your driver.
(i.e. removing SNDRV_PCM_INFO_MMAP from info field of hw struct).

The ALSA core part believes that the buffer is mmappable as long as
that flag is set, regardless whether it's allocated via
dma_alloc_coherent() or anything else.

I have a hack on my local tree to adapt the new dma_to_*() macros for
ARM, but it's not clean enough yet for merging to the main ALSA tree.

I hope in future the kernel will have a support function for easier
mmap as Russell proposed on lkml.


Takashi


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


>From my understanding you are saying that I can get my driver working
with the current ALSA by removing the _MMAP_ flags.=20

runtime->hw.info &=3D ~(SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID);

However, I do not have a pointer to the runtime or the substream at this
stage. How do I change the HW permissions before I call
snd_pcm_lib_preallocate_pages_for_all, where everything crashes, which
is called in snd_mychip_new_pcm? I believe they are set only in the open
callback in the example from the documentation.

Best regards,=20
=20
Bo Henriksen



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
