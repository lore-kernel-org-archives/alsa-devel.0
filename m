From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Intel 8x0 static & compile error
Date: Tue, 2 Dec 2003 14:05:54 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031202110554.GK988@master.mivlgu.local>
References: <92C0412E07F63549B2A2F2345D3DB515F7D302@cm-msg-02.cmedia.com.tw> <s5hu14jebt7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hu14jebt7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2003 at 11:47:16AM +0100, Takashi Iwai wrote:
> At Tue, 2 Dec 2003 17:36:41 +0800,
> C.L. Tien - ????????? <cltien@cmedia.com.tw> wrote:
> > 
> > I found that if I forced the aRtsd use 48000 sample rate then there
> > is no the static problem, I guess there is a problem in SW sample rate
> > converter. 
> 
> ok, at least, a step forward :)
> could you tell me whether it runs on ALSA native or OSS mode?
> (i guess the latter.)

BTW, I have experienced the same problem (static and distortion after
about 20 seconds) with VIA VT8235 when loading snd-via82xx with
dxs_support=3 (so that it will be 48k only).  This was with ALSA 0.9.8
(did not have a chance to try 1.0.0rc1 on that machine).

When trying to use OSS apps with 44100 sample rate in this configuration,
I got distortion after about 20 seconds of playback.  When trying ALSA
output in xmms, there was no such distortion, but some static was heard.

--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zHISW82GfkQfsqIRAgTLAJwKawsP7YqZ675AwNzs61fmEGhwuwCeN+i9
11s1AJ9LWsfYsjJWHrm0dyg=
=en8i
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
