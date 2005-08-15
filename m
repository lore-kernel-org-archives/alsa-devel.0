From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compulab sound device
Date: Mon, 15 Aug 2005 09:41:17 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508150936140.21757-100000@studcom.urz.uni-halle.de>
References: <20050815030641.94973.qmail@web54605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050815030641.94973.qmail@web54605.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Chow Raymond wrote:
> Does ALSA support ac97 codec as a soundcard?

An AC'97 codec is always connected to an AC'97 controller.  It's the
controller that would be supported (or not) by ALSA.

> Im not too sure whether ac97 can work on the Compulab Armcore
> board.

ALSA has a driver for the AC'97 controller in the PXA2xx chip
(snd-pxa2xx-ac97).


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
