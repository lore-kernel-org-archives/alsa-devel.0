From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: es1938 kernel panic - buffer overrun on recording
Date: Wed, 07 Jun 2006 20:43:53 -0400
Message-ID: <1149727433.3151.1.camel@mindpipe>
References: <367a23780606061401h6edfb8bcvf9b77f24415aa45f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <367a23780606061401h6edfb8bcvf9b77f24415aa45f@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Kacper Wysocki <kacperw@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-06 at 17:01 -0400, Kacper Wysocki wrote:
> Hi,
> I'm running linux 2.6.16.5 and have a esssolo1 soundcard built into my
> IBM Thinkpad 240. Anytime I try to record from the soundcard I get the
> following message on the console:
> 
> kernel panic - not syncing: Buffer above 16M boundry
> 
> This is reproducible with for example 'sound-recorder foo.wav' or any
> other program that reads from the soundcard.
> 
> I would be happy to debug it further, but I would need some pointers
> as to what to do, as I couldn't find a debug mode for the alsa es1938
> kernel driver.

Can you post the full kernel panic output?

Lee
