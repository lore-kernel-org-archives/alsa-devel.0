From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
Date: Tue, 26 May 2009 13:49:48 +0100
Message-ID: <200905261349.49832.arnd@arndb.de>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
	<alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tuesday 26 May 2009, Geert Uytterhoeven wrote:
> However, you can still improve useability by making the macro return the rc,
> instead of letting the caller pass it, cfr. wait_event_timeout() and friends.

Either that, or it should at least use the do { ... } while (0) construct
to make the macro a statement. All multi-line macros need to either
use ({ ... }) or do { ... } while (0) to make sure they behave well.

	Arnd <><
