From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Minimum period size of M-Audio Delta 44?
Date: Fri, 9 Sep 2005 15:48:18 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509091535130.15023-100000@studcom.urz.uni-halle.de>
References: <20050909104023.GA25499@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050909104023.GA25499@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Asbj=F8rn S=E6b=F8 wrote:
> What is the minimum period size of the M-Audio Delta 44 soundcard when
> running under ALSA?

The snd-ice1712 driver uses a minimum period size of 80 bytes.

> (I am thinking of bying such a card, but would prefer the
> attainable latency to be low.)

The ICE1712 chip uses 40 bytes per frame (ten channels with 32 bits),
so the minimum latency at 96 kHz would be 0.02 milliseconds.

A modern computer might actually survive 48000 PCM interrupts per
second.  ;-)


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
