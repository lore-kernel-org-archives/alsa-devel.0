From: Juan Linietsky <coding@reduz.com.ar>
Subject: Question regarding thread safety
Date: Fri, 7 Nov 2003 09:03:48 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311070903.48993.coding@reduz.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello! I wish to implement a midi sensing thread which listens
in blocking mode to the midi port until there is data avaiable.
The purpose of this is so i can properly timestamp ANY incoming
realtime events (as events that are input via the midi port, or from clients 
that send in real time are not timestamped upon delivery).
But my doubt is how should I terminate this thread on driver exit...
should i attempt to unblocking it by closing the descriptor, or is there
anything else i could try?

Thanks!

Juan Linietsky



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
