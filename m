From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: Terratec Aureon Space
Date: Mon, 19 May 2003 21:29:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EC93093.1090003@student.kuleuven.ac.be>
References: <200305170831.13014.zeb@zebulon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?Big5?B?IlrpYnVsb24gKGJ5IHdheSBvZiBa6WJ1bG9uIDw+KSI=?= <zeb@zebulon.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ze'bulon (by way of Ze'bulon <>) wrote:

>>only if we get enough technical information...
>>
>>at least we need to know the wire connection between codec and ice1724
>>chips, especially 61, 62 and 63 pins of Wolfson chip and GPIO pins of
>>ice1724 chip.
>>    
>>
>
>Would it be possible to find it by analysing the circuits on the card itself
> ?
>  
>
Chances are that this is possible. I did it for the maxistudio isis.
You'll need a multimeter with a beep function and some common sense
knowledge of which connections are most likely.
Most PCI cards are 4 layer PCB's with power and ground distribution on
the inner layer. This means that the signal traces are on the outside of
the board, so you can use a magnifying glass to trace them. Using a
digital camera with proper lighting works even better. You make a
picture of the piece of board you want to analyze (of both sides of
course), with a good resolution. This gives you a more 'stable' view of
the traces.

Pieter




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
