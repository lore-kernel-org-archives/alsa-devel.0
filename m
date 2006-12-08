From: James Courtier-Dutton <James@superbug.co.uk>
Subject: alsa-lib bloat.
Date: Fri, 08 Dec 2006 12:37:01 +0000
Message-ID: <45795C6D.9030100@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On my desktop system, I have this:
/usr/lib/libasound.so.2.0.0
size: 2785380 bytes.

libasound is really too big for what is does.
I was talking to some embedded platform developers recently, and they 
really don't like it at all.

Could something be done about it?
I was thinking that we could really cut down the API to a very limited 
subset of the current api, and place #ifdef in the source code, so that 
developers could build alsa-lib for embedded systems using just this 
subset of the current api. I would suggest just using the poll() 
callback method would be needed, as then it is similar to Mac OS X, and 
generally accepted as the best way to talk to a sound device.

I would also like to ask any embedded developers out there who have 
already done this, to post patches back to ALSA so that it saves 
developers time in future.

How about also separating libasound into separate libs, one for PCM, one 
for MIDI, and one for CONTROL that could in turn use a separate "helper 
functions" lib for any common functions. Some embedded applications 
might not need any of the MIDI/sequencer stuff.

Any comments?

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
