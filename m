From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Pause and Resume testing needed
Date: Sat, 13 Apr 2002 16:03:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CB848B0.6080001@superbug.demon.co.uk>
References: <3CB83E44.10402@superbug.demon.co.uk>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James@superbug.demon.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:

> Hello
>
> Are there any test applications which test the pause/resume 
> functionallity.
>
> I have an app which is calling pause, then resume, but after resume, 
> the sound is very choppy.
>
> I was hoping that there was an application out there which already 
> worked with pause/resume so I can narrow down the problem to alsa or 
> my application.
>
> Cheers
> James
>
>
I found out what is wrong with my pausing problem. It is an alsa bug.

I have a SB Live.
pausing and resuming works fine in all modes except AC3 passthru.
If one paused an AC3 passthru stream, it becomes very jumpy.

Cheers
James
