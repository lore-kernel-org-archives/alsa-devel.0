From: Andreas Degert <ad@papyrus-gmbh.de>
Subject: Re: hdsp driver broken for Multiface II Rev 35
Date: Tue, 15 Jan 2008 20:42:15 +0100
Message-ID: <20080115204215.2dfb6544@pluto.noname>
References: <20080114022142.51d6ae44@pluto.noname>
	<s5hbq7ollj9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_Krfvm3Cd7xVKCJTGE2X0OwG
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from papyrus-gmbh.de (fw.papyrus-gmbh.de [62.153.85.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B9A02438A
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 20:42:16 +0100 (CET)
In-Reply-To: <s5hbq7ollj9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_Krfvm3Cd7xVKCJTGE2X0OwG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 14 Jan 2008 12:00:10 +0100
Takashi Iwai <tiwai@suse.de> wrote:

[...]
> > 
> > static int hdsp_playback_to_output_key (struct hdsp *hdsp, int in,
> > int out) {
> >         switch (hdsp->io_type) {
> >         case Multiface:
> >         case Digiface:
> >         default:
> >                 if (hdsp->firmware_rev == 0xa)
> >                         return (64 * out) + (32 + (in));
> >                 else
> >                         return (52 * out) + (26 + (in));
> >         case H9632:
> >                 return (32 * out) + (16 + (in));
> >         case H9652:
> >                 return (52 * out) + (26 + (in));
> >         }
> > }
> 
> This looks OK.  Could you prepare a patch (with a proper changelog and
> your sing-off)?

ok, here it is:

hdsp: make Multiface II work again

This device has io_type == 1 (Multiface) and firmware_rev > 0xa
(fixes regression from changeset 5326)

Signed-off-by: Andreas Degert <ad@papyrus-gmbh.de>


--MP_Krfvm3Cd7xVKCJTGE2X0OwG
Content-Type: text/x-patch; name=hdsp.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hdsp.patch

diff -r 1f9fd3d3cb12 -r d06a33481e0d pci/rme9652/hdsp.c
--- a/pci/rme9652/hdsp.c	Mon Jan 14 12:07:53 2008 +0100
+++ b/pci/rme9652/hdsp.c	Tue Jan 15 20:29:52 2008 +0100
@@ -607,7 +607,10 @@ static int hdsp_playback_to_output_key (
 	case Multiface:
 	case Digiface:
 	default:
-		return (64 * out) + (32 + (in));
+		if (hdsp->firmware_rev == 0xa)
+			return (64 * out) + (32 + (in));
+		else
+			return (52 * out) + (26 + (in));
 	case H9632:
 		return (32 * out) + (16 + (in));
 	case H9652:
@@ -621,7 +624,10 @@ static int hdsp_input_to_output_key (str
 	case Multiface:
 	case Digiface:
 	default:
-		return (64 * out) + in;
+		if (hdsp->firmware_rev == 0xa)
+			return (64 * out) + in;
+		else
+			return (52 * out) + in;
 	case H9632:
 		return (32 * out) + in;
 	case H9652:

--MP_Krfvm3Cd7xVKCJTGE2X0OwG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_Krfvm3Cd7xVKCJTGE2X0OwG--
