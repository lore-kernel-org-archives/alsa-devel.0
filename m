From: Lars Heineken <Lars.Heineken@gmx.de>
Subject: Re: Low recording quality on ice1712
Date: Mon, 10 Nov 2003 19:17:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FAFD631.4000104@gmx.de>
References: <3FAEA696.6040809@gmx.de> <s5hfzgwcd7c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzgwcd7c.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai wrote:

| At Sun, 09 Nov 2003 21:41:58 +0100, Lars Heineken wrote:
|
|> Hi !
|>
|> I've been a member of htis list some time ago, and now I'm facing a
|> new problem: Playback through my Terratec EWX 24/96 (ice1712) on
|> Mandrake 9.1 is fine and crysrtal clear, but recorded stuff (using
|> arecord -f cd) sounds damped, just like beeing recorded in 22000
|> kHz. I have created an .asoundrc in my home directory identically
|> to the example on the alsa project page but it didn't help. I tried
|> to record in WinXP, and as always, recording works fine there no
|> damped sound. It's definitely not a hardware issue.
|
|
| i suspect the mixer misconfiguration, rather than a general problem
| of the ice1712 driver.  note that ~/.asoundrc has nothing to do with
| the mixer setting.
|
| how did you adjust the mixer setting?


I just figured out that Mandrake used a very old alsa version (0.9rc8)
and I decided to switch to the latest. It's working fine now.
I'm still investigating wether this is related to my driver upgrade or
the fact that I freed up another IRQ. Could a shared interrupt produce
damped sound while recording ? (The sound was not digitally distorted at
any time)

Regards,

Lars.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/r9Yxrp9JEomxNXERAtF3AKD0l4zTucuj3m2LsaF/kBTbcmptrACg+F7i
4y1UdQy2T3R+SLwbNfqgndU=
=UGgP
-----END PGP SIGNATURE-----




-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
