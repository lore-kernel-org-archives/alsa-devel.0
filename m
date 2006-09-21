From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Can't set less than 48k rate in the Intel-ICH4
 (AD1981B)
Date: Thu, 21 Sep 2006 09:39:42 +0200
Message-ID: <1158824382.14818.271465641@webmail.messagingengine.com>
References: <20060921130546.02f871fe@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060921130546.02f871fe@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Junji Umeno <umeno@elwsc.co.jp>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Junji Umeno wrote:
> I can't set less than 48kHz rate for capture sampling.
> In my case,
> Alsa prepares 4 pcm devices, 
> and I use the first 0-0 and the 4th 0-3, each playback and capture.

So your system has more than one codec?

> But when I set to the 3rd less than 48k rate, 
> Alsa shows error,"cannot set sample rate".
> On the other way, 
> the 1st can be set less than 48k rate as a capture port. 

I'd guess the codec connected to the ICH4's 4th DMA input is another
model.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
