From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: IEC958 plugin and Rate plugin programming
Date: Tue, 14 Feb 2006 15:30:17 +0100
Message-ID: <20060214143017.GA11753@turing.informatik.uni-halle.de>
References: <43EDAE9C.7060808@gmail.com>
 <20060213081740.GB8896@ifiu25.informatik.uni-halle.de>
 <43F0A236.8050604@gmail.com>
 <20060213160231.GG9177@ifiu25.informatik.uni-halle.de>
 <43F1AF7B.1020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <43F1AF7B.1020909@gmail.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Luca Piccioni <luca.piccioni@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luca Piccioni wrote:
> 
> Clemens Ladisch wrote:
> 
> > What is the output of "iecset"?
> 
> $iecset
> Mode: consumer
> Data: audio
> Rate: 48000 Hz
> Copyright: permitted
> Emphasis: none
> Category: PCM coder
> Original: original
> Clock: 1000 ppm
> 
> $iecset -x
> AES0=0x04,AES1=0x82,AES2=0x00,AES3=0x02

Try playing to the device
"plug:iec958:AES0=0x04,AES1=0x82,AES2=0x00,AES3=0x02".

> I don't understand many thing... first "professional" and "consumer"
> modes: how they influence my applications?

It's a different setting of the status bits in the SPDIF frames.
Professional mode is for people that don't want to be bothered by the
simple copy protection scheme (disallow copying when the copyright bit
is set), but most consumer devices don't support it.

The default should work just fine.

> What are that parameters AES*?

The same parameters, only in a format that the computer can understand
them.


Regards,
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
