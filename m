From: "Gibson, Nelson" <ngibson@dsrnet.com>
Subject: RME9636 and 0.9.0rc3 problems
Date: Thu, 12 Sep 2002 16:24:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33F012255162604984A3F4BDA95C6EC402063B71@mstaex1b.DSRUSI.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am us an RME9636 (Hammerfall Light) and ALSA version 0.9.0rc3.  I am =
having problems captureing data from the card.  The program that I was =
orginally using was created with ALSA 0.9.0beta6 and I was able to read =
2 channels of data off of the card.  Unfortunally, with the move from =
the PIII platform to the P4 we had to upgrade redhat/kernel and the =
beta6 version does not compile anymore.  Now when I try to compile our =
software the program does not read 2 channels of data anymore. =20

Hoping I could find the problem I am now trying to write a basic program =
to see what we could be doing wrong.  I took the example by Dr. Matthias =
Nagorni from the ALSA website (found at: =
www.suse.de/~mana/alsa090_howto.html).  I made a few slight changes =
which I can describe if need be, but their nothing that should be =
causing errors.  Anyhow, the sample program is errors out (with value =
-22)when I try to use the call=20
if(snd_pcm_hw_params(pcm_handle, hwparams) < 0) {
  fprintf(stderr, "Error setting HW params.\n);
  return(-1);
}

I have been in correspondance with Mr. Paul Davis and he(we) has =
concluded that it's not a problem with the RME9652 driver, but somewhere =
in the kernel/library.  Any help on this would be appreciated.

---------------------------------------------------------------------
Nelson Gibson II
TCNI and DSR
Phone: 703.263.2800x1032
Fax:     707.922.6001
email: gibson@tcni.com or ngibson@dsrnet.com

"A Co-Op is NOT an intern, we're better then them"



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
