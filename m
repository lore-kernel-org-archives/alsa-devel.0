From: Raymond <rayau@netvigator.com>
Subject: Re: Disagreement about versions following CVS   update
Date: Sun, 21 Aug 2005 08:55:37 +0800
Message-ID: <4307D109.5040709@netvigator.com>
References: <43063408.60402@redfish-solutions.com>	 <4306D911.70101@netvigator.com> <1124571984.2115.5.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1124571984.2115.5.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sat, 2005-08-20 at 15:17 +0800, Raymond wrote:
> 
>>./configure: line 4415: syntax error near unexpected token `<<<'
>>./configure: line 4415: `<<<<<<< configure.in' 
> 
> 
> This indicates a CVS merge conflict.  Try a fresh checkout.
> 
> Lee
> 

It's strange to find the following mixer controls in CAPTURE VIEW of 
alsamixer v1.0.10rc1 :-


# amixer -version
amixer version 1.0.10rc1

Simple mixer control '3D Control Sigmatel - Depth',0
   Capabilities: volume volume-joined
   Playback channels: Mono
   Capture channels: Mono
   Limits: 0 - 3
   Mono: 0 [0%]
Simple mixer control '3D Control Sigmatel - Rear Depth',0
   Capabilities: volume volume-joined
   Playback channels: Mono
   Capture channels: Mono
   Limits: 0 - 3
   Mono: 0 [0%]


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
