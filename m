From: vanDongen/Gilcher <gml@xs4all.nl>
Subject: Re: full-duplex - is it possible with rme32?
Date: Wed, 19 Jun 2002 11:44:50 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0CgYqL447A140000.gml@xs4all.nl>
References: <E17KOUR-0002SW-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17KOUR-0002SW-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I wonder how the mac driver does it, because I have full duplex working on 
my mac with an rme32/8.
It must be possible. 


> 
> I asked RME about the real behaviour and the answer was something like 
> this:
> The sample for playing is the first one in the buffer. Capturing at the 
> same
> time will overwrite this sample...
> 
> So we have the hardware sequence: capture -> playback
> and this is like "good-bye full duplex!" for the rme32.
>

I don't think this is  a conclusion you make from that info. 

Gerard


----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                   >>>     http://thinkgeek.com/sf    <<<
