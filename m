From: vollmer.philipp@t-online.de (Philipp Vollmer)
Subject: Alsa Programming Examples
Date: Fri, 7 Jun 2002 22:14:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206072212.56183.do1ypv@linux>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
List-Id: alsa-devel@alsa-project.org

Hello to all ALSA developers!

I had compiled the examples of the Programming HOWTO succesfully!!!
I saw many programming mistakes in these files. I don't think ANSI C supp=
orts=20
polymorphism! So I had to take parts out of other running code and put it=
=20
into the example.
But now, after a few changes I could run the program which starts to send=
=20
Random PCM Data to the interface.

Now I have following problem:
Although the program compiled succesfully I get following output:

how1: pcm_params.c:2136: snd_pcm_hw_refine: Assertion && params failed.
Canceled

What is the problem?
( My conditions:
CMI8738
ALSA 0.90 driver and library
)

Yours Philipp Vollmer



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
