From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [Fwd: AudioTrak Prodigy 7.1 support - patch]
Date: Wed, 12 Nov 2003 20:09:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031112190954.GB1118@tuba.home>
References: <3FAEFCFC.9000606@aei.ca> <20031111225325.GA6345@tuba.home> <3FB1DD9E.3040708@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3FB1DD9E.3040708@aei.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Apostolos Dimitromanolakis <apostolos@aei.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2003 at 02:13:34AM -0500, Apostolos Dimitromanolakis wrote:
> 
> My mistake..  fixed!

Yes, it's fixed. But I think this patch is better.

martin



--- ../alsa-cvs/alsa-kernel/pci/ice1712/prodigy.c	Mon Nov 10 19:00:50 2003
+++ alsa-kernel/pci/ice1712/prodigy.c	Wed Nov 12 19:59:33 2003
@@ -163,8 +163,6 @@
 
 static int prodigy_hpamp_info(snd_kcontrol_t *k, snd_ctl_elem_info_t *uinfo)
 {
-        uinfo->type= SNDRV_CTL_ELEM_TYPE_INTEGER;
-
 	static char *texts[2] = {
 		"Off", "On"
 	};


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
