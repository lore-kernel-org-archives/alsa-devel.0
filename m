From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: multiple cards mounted
Date: Fri, 5 Aug 2005 18:24:08 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508051821350.3253-100000@studcom.urz.uni-halle.de>
References: <42F37908.2050701@indt.org.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42F37908.2050701@indt.org.br>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Cohen <david.cohen@indt.org.br>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Cohen wrote:
> I am trying to write a alsa driver as a module. But after load and
> unload this module, the card is still mounted. If I try to load it
> again, it shows the same card mounted twice. How can I solve this
> problem? What should I put into the module_exit function?

Something that directly or indirectly calls snd_card_free().  See any
other driver for examples.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
