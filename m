From: Paul Davis <pbd@Op.Net>
Subject: Re: How to detect sample rate change in runtime?
Date: Mon, 25 Mar 2002 14:30:39 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203260030.TAA20911@renoir.op.net>
References: <200203251755.g2PHtG925535@d1o840.telia.com>
In-Reply-To: Your message of "Mon, 25 Mar 2002 18:55:15 +0100."
             <200203251755.g2PHtG925535@d1o840.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I want to be able to detect when sample rate changes during runtime. 
>
>An example scenario (by coincidence very similar to my application): a 
>multi-channel convolution engine runs on an RME9652 which operates at 
>44.1 kHz as clock slave. However, in runtime, the user switches cables 
>to the card, which changes the sample rate to 48 kHz. Then the 
>convolution engine gets a signal or something from ALSA that says "hey, 
>the sample rate changed to 48 kHz, what are you going to do about it?", 
>and then the convolution engine changes filters to those designed for 
>48 kHz, or exits with an error if they don't exist.
>
>So, what methods are there to solve this problem?

>From the ControlNames file in alsa-driver/doc:

PCM interface:

  Sample Clock Source	{ "Word", "Internal", "AutoSync" }
  Clock Sync Status	{ "Lock", "Sync", "No Lock" }
  External Rate		/* external capture rate */
  Capture Rate		/* capture rate taken from external source */

As you can see, this is very confused since "External Rate" and
"Capture Rate" are apparently the same thing. Moving on ...

So, the generic way to catch this is to watch the PCM control switches
named "External Rate" and/or "Capture Rate", using poll(2) to watch
for read status on the switches, and then their value when they change.

However, for this to work, the low level driver has to implement it too.

the RME9652 driver had code to catch this at some point, wherein it
watched the rate, and generated an error if you tried to read/write
after the rate changed. but i removed this code because it wasn't the
right thing to do.

At this time, therefore, I don't think that there is general support
for this. It would be good to add this any and all cards that support
word clock and/or sync-to-signal-clock (eg. ADAT or IEC958 signal
clock). 

--p
