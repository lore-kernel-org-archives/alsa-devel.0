From: Tom Watson <sdc695@yahoo.com>
Subject: Re: How to tweak dmix?
Date: Thu, 10 Mar 2005 22:22:36 -0800 (PST)
Message-ID: <20050311062237.93862.qmail@web60801.mail.yahoo.com>
References: <20050311002002.4B6B412867@sc8-sf-spam2.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050311002002.4B6B412867@sc8-sf-spam2.sourceforge.net>
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

--- Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Message: 2
> Date: Thu, 10 Mar 2005 23:14:29 +0100
> From: Pierre Ossman <drzeus-list@drzeus.cx>
> 
> I've been looking for some guides on how you tweak the parameters in
> dmix to get what you want but I haven't found any. I can just find
> example after example without any explanation of the parameters.
> 
> The reason I want to tweak it is because the sound isn't "just right". I
> can either get a lot of stuttering, or very short samples fail to be played.
> 
> My current setting is:
> 
> period_time	84000
> buffer_time	340000
> period_size	4096
> buffer_size	32768
> 
> This gives me pleasant sound as long as the samples are long enough.
> Short things newer survive long enough to reach the speakers.
> 
> If I remove *_size and set period_time to around half of buffer_time
> then I can get short samples to play. But longer samples start to
> stutter and the sound is awful.
> 
> I've been playing around with the values but since I don't really know
> what I'm changing I haven't been able to find a solution that works
> well. So I could really use some help here.
> 
> Rgds
> Pierre
> 
> 
I, too have struggled with these parameters.  The application I'm working with
has no issues with latency (playback only), but stuttering IS a huge problem. 
While I'm not really using dmix (I call the '...writei' routine directly), a
proper setting of these would be nice.  What are the guidelines for these
parameters, and what is their interaction?  Obviously they DO something, or the
would be fixed to some value.  Do they matter if the number of channels varies?
 The documentation isn't as clear as it could be.

Thanks.

p.s.  In a couple of different applications (aplay among them), it seems that I
get different "defaults" evn with the same (I try very hard here!) operating
environment.  Do they change with different versions of the alsa lib?

Thanks again.

-- 
Tom Watson
tsw@johana.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
