From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with snd_mixer_selem_set_playback_volume_range()
Date: Tue, 9 Dec 2003 10:47:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312091045200.20863@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0312090049431.6730-100000@foo.kvaalen.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0312090049431.6730-100000@foo.kvaalen.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?H=E5vard_Kv=E5len?= <havardk@xmms.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Dec 2003, H?vard Kv?len wrote:

> Hi, I'm having a problem with snd_mixer_selem_set_playback_volume_range().  
> It works ok, except that the values I read back (with
> snd_mixer_selem_get_playback_volume()) does not seem to be scaled with the
> new range until the volume is changed somehow.  Both changing the volume
> by calling snd_mixer_selem_get_playback_volume() and using some external
> program helps.
> 
> Am i supposed to do something more after calling 
> snd_mixer_selem_set_playback_volume_range() or is this a bug?

It looks like a bug. Could you try this patch (it's also in CVS)?

					Jaroslav

Index: simple.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/mixer/simple.c,v
retrieving revision 1.60
diff -u -r1.60 simple.c
--- simple.c	19 Nov 2003 15:52:16 -0000	1.60
+++ simple.c	9 Dec 2003 09:47:12 -0000
@@ -1388,10 +1388,12 @@
 	selem_t *s;
 	assert(elem);
 	assert(elem->type == SND_MIXER_ELEM_SIMPLE);
+	assert(min < max);
 	s = elem->private_data;
 	s->str[PLAY].range = 1;
 	s->str[PLAY].min = min;
 	s->str[PLAY].max = max;
+	selem_read(elem);
 }
 
 /**
@@ -1648,10 +1650,12 @@
 	selem_t *s;
 	assert(elem);
 	assert(elem->type == SND_MIXER_ELEM_SIMPLE);
+	assert(min < max);
 	s = elem->private_data;
 	s->str[CAPT].range = 1;
 	s->str[CAPT].min = min;
 	s->str[CAPT].max = max;
+	selem_read(elem);
 }
 
 /**

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
