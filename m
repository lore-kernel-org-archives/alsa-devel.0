From: Peter Surda <shurdeek@panorama.sth.ac.at>
Subject: second repost: oops on intel8x0
Date: Thu, 14 Feb 2002 00:15:43 +0100
Message-ID: <a4esqj$1fj$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="WWBpDPuG52WufD7Q"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--WWBpDPuG52WufD7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I complained some time ago, several times, that 32kHz seems to produce oops on
my onboard ECS K7S5A. It seems it isn't exactly 32kHz producing this, but
buffer size combined with frequency. Because current cvs aviplay also manages
to cause oops on 44.1kHz. Zdenek, aviplay maintainer, told me he shrunk the
buffer size from 4 to 2 kB to obtain better interactive responsiveness.

So it seems ("educated guess") than some buffer offsets aren't calculated
correctly in intel8x0 (my sblive which I use as a second card has no such
problems), and produces buffer overflow when too small.

Becase I have received exactly 0 replies to all of my previous 3 emails, which
IMHO provided enough information, now I'll be a little bit harsher:

SOMEBODY BETTER FIX IT OR GIVE ME HINTS WHERE TO LOOK!

(hint: snd_intel8x0_setup_periods perhaps?)

I repeat: RH 7.1, kernel 2.4.18-pre4 with O(1), ide and preempt patches,
Duron900 (not overclocked), 192MB RAM, alsa 0.9.0beta10

Here are the damn oops-es:
------------------------------------------------------------------
Feb 13 23:04:01 ten kernel: Unable to handle kernel paging request at virtual address cee16000
Feb 13 23:04:01 ten kernel:  printing eip:
Feb 13 23:04:01 ten kernel: ceec8260
Feb 13 23:04:01 ten kernel: *pde = 0742e067
Feb 13 23:04:01 ten kernel: *pte = 00000000
Feb 13 23:04:01 ten kernel: Oops: 0000
Feb 13 23:04:01 ten kernel: CPU:    0
Feb 13 23:04:01 ten kernel: EIP:    0010:[<ceec8260>]    Not tainted
Feb 13 23:04:01 ten kernel: EFLAGS: 00010202
Feb 13 23:04:01 ten kernel: eax: 00000001   ebx: 00000000   ecx: 00000014   edx: 0000075a
Feb 13 23:04:01 ten kernel: esi: 0000001f   edi: cee16000   ebp: 00000014   esp: c9da9e88
Feb 13 23:04:01 ten kernel: ds: 0018   es: 0018   ss: 0018
Feb 13 23:04:01 ten kernel: Process aviplay (pid: 1799, stackpage=c9da9000)
Feb 13 23:04:01 ten kernel: Stack: ceec8483 ceec8504 ceec8260 c8fd960c c8fd95f0 00000000 00000004 00000004
Feb 13 23:04:01 ten kernel:        00000000 cee0e2d0 00144e38 0000008c 000008b5 00000800 c8fd9580 ca4570c0
Feb 13 23:04:01 ten kernel:        ceec8b0a c8fd9580 c6234e00 c6234b40 000007ff 000008b5 c8fd9580 00000800
Feb 13 23:04:01 ten kernel: Call Trace: [<ceec8483>] [<ceec8504>] [<ceec8260>] [<ceec8b0a>] [<ceec5974>]
Feb 13 23:04:01 ten kernel:    [<ceec1e91>] [<ceec2013>] [<ceec3d63>] [<c0136fb5>] [<c0106fbb>]
Feb 13 23:04:01 ten kernel:
Feb 13 23:04:01 ten kernel: Code: 0f b7 37 0f bf cd ff 24 24 8d b4 26 00 00 00 00 0f b7 37 0f
------------------------------------------------------------------
Feb 13 14:39:32 ten kernel: Unable to handle kernel paging request at virtual address ceed4000
Feb 13 14:39:32 ten kernel:  printing eip:
Feb 13 14:39:32 ten kernel: cd97b260
Feb 13 14:39:32 ten kernel: *pde = 07b8c067
Feb 13 14:39:32 ten kernel: *pte = 00000000
Feb 13 14:39:32 ten kernel: Oops: 0000
Feb 13 14:39:32 ten kernel: CPU:    0
Feb 13 14:39:32 ten kernel: EIP:    0010:[<cd97b260>]    Not tainted
Feb 13 14:39:32 ten kernel: EFLAGS: 00010202
Feb 13 14:39:32 ten kernel: eax: 00000001   ebx: 00000000   ecx: 00000000   edx: 0000075a
Feb 13 14:39:32 ten kernel: esi: 00000000   edi: ceed4000   ebp: 00000000   esp: c872de88
Feb 13 14:39:32 ten kernel: ds: 0018   es: 0018   ss: 0018
Feb 13 14:39:32 ten kernel: Process aviplay (pid: 25754, stackpage=c872d000)
Feb 13 14:39:32 ten kernel: Stack: cd97b483 cd97b504 cd97b260 c982710c c98270f0 00000000 00000004 00000004
Feb 13 14:39:32 ten kernel:        00000000 ceebe2d0 00001378 0000008c 000008b5 00000800 c9827080 c8de0a40
Feb 13 14:39:32 ten kernel:        cd97bb0a c9827080 c9471340 c94719c0 000007ff 000008b5 c9827080 00000800
Feb 13 14:39:32 ten kernel: Call Trace: [<cd97b483>] [<cd97b504>] [<cd97b260>] [<cd97bb0a>] [<cd978974>]
Feb 13 14:39:32 ten kernel:    [<cd974e91>] [<cd975013>] [<cd976d63>] [<c0136fb5>] [<c0106fbb>]
Feb 13 14:39:32 ten kernel:
Feb 13 14:39:32 ten kernel: Code: 0f b7 37 0f bf cd ff 24 24 8d b4 26 00 00 00 00 0f b7 37 0f
------------------------------------------------------------------
Jan 24 04:28:05 ten kernel: Unable to handle kernel paging request at virtual address ceea9000
Jan 24 04:28:05 ten kernel:  printing eip:
Jan 24 04:28:05 ten kernel: cee29260
Jan 24 04:28:05 ten kernel: *pde = 078bc067
Jan 24 04:28:05 ten kernel: *pte = 00000000
Jan 24 04:28:05 ten kernel: Oops: 0000
Jan 24 04:28:05 ten kernel: CPU:    0
Jan 24 04:28:05 ten kernel: EIP:    0010:[<cee29260>]    Not tainted
Jan 24 04:28:05 ten kernel: EFLAGS: 00010202
Jan 24 04:28:05 ten kernel: eax: 00000001   ebx: 00000000   ecx: 00000000   edx: 00000555
Jan 24 04:28:05 ten kernel: esi: 00000000   edi: ceea9000   ebp: 00000000   esp: c992de88
Jan 24 04:28:05 ten kernel: ds: 0018   es: 0018   ss: 0018
Jan 24 04:28:05 ten kernel: Process aviplay (pid: 5051, stackpage=c992d000)
Jan 24 04:28:05 ten kernel: Stack: cee29483 cee29504 cee29260 c274c54c c274c530 00000000 00000004 00000004
Jan 24 04:28:05 ten kernel:        00000000 cef04004 00003c78 000002a9 00001802 00001000 c274c4c0 c26e2740
Jan 24 04:28:05 ten kernel:        cee29b0a c274c4c0 c3833c40 c38332c0 00000fff 00001802 c274c4c0 00001000
Jan 24 04:28:05 ten kernel: Call Trace: [<cee29483>] [<cee29504>] [<cee29260>] [<cee29b0a>] [<cee26974>]
Jan 24 04:28:05 ten kernel:    [<cee22e91>] [<cee23013>] [<cee24d63>] [<c0136fb5>] [<c0106fbb>]
Jan 24 04:28:05 ten kernel:
Jan 24 04:28:05 ten kernel: Code: 0f b7 37 0f bf cd ff 24 24 8d b4 26 00 00 00 00 0f b7 37 0f
------------------------------------------------------------------
Jan 24 06:23:28 ten kernel: Unable to handle kernel paging request at virtual address cf2b3000
Jan 24 06:23:28 ten kernel:  printing eip:
Jan 24 06:23:28 ten kernel: cf2ac260
Jan 24 06:23:28 ten kernel: *pde = 07b17067
Jan 24 06:23:28 ten kernel: *pte = 00000000
Jan 24 06:23:28 ten kernel: Oops: 0000
Jan 24 06:23:28 ten kernel: CPU:    0
Jan 24 06:23:28 ten kernel: EIP:    0010:[<cf2ac260>]    Not tainted
Jan 24 06:23:28 ten kernel: EFLAGS: 00010202
Jan 24 06:23:28 ten kernel: eax: 00000001   ebx: 00000000   ecx: ffffec29   edx: 00000555
Jan 24 06:23:28 ten kernel: esi: ffffecb3   edi: cf2b3000   ebp: 0000ec29   esp: c434be88
Jan 24 06:23:28 ten kernel: ds: 0018   es: 0018   ss: 0018
Jan 24 06:23:28 ten kernel: Process aviplay (pid: 1110, stackpage=c434b000)
Jan 24 06:23:28 ten kernel: Stack: cf2ac483 cf2ac504 cf2ac260 c5fe2e0c c5fe2df0 00000000 00000004 00000004
Jan 24 06:23:28 ten kernel:        00000000 cf3bb004 ec291cb8 000002a9 00001802 00001000 c5fe2d80 cb240c40
Jan 24 06:23:28 ten kernel:        cf2acb0a c5fe2d80 c5fe1c80 c5fe1cc0 00000fff 00001802 c5fe2d80 00001000
Jan 24 06:23:28 ten kernel: Call Trace: [<cf2ac483>] [<cf2ac504>] [<cf2ac260>] [<cf2acb0a>] [<cf2a9974>]
Jan 24 06:23:28 ten kernel:    [<cf2a5e91>] [<cf2a6013>] [<cf2a7d63>] [<c0136fb5>] [<c0106fbb>]
Jan 24 06:23:28 ten kernel:
Jan 24 06:23:28 ten kernel: Code: 0f b7 37 0f bf cd ff 24 24 8d b4 26 00 00 00 00 0f b7 37 0f
------------------------------------------------------------------

After they happen, sound card remains silent and module blocked.

In the end I'd like to thank you all for your work, I remember when alsa was
in the beginnings, I used the special gus modules on my interwave clone to get
wavetable working. Your communicativeness seems to be lacking however, is it
REALLY that difficult to write "Hmm, sounds strange, I have no idea what could
be causing this, can you do more tests with xyz"?

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505122023

--
          "One world, one web, one program"  -- Microsoft promotional ad
         "Ein Volk, ein Reich, ein Fuehrer"  -- Adolf Hitler
         "Ein Auto, ein Computer, ein Mann"  -- Knight Rider

--WWBpDPuG52WufD7Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8avOfzogxsPZwLzcRAhZ9AJ40mnfbyJpGqcgemxRu/op+Id4DRwCfVMuB
kB/1f3QfusRPXCvbGD8XB/g=
=LMPO
-----END PGP SIGNATURE-----

--WWBpDPuG52WufD7Q--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
