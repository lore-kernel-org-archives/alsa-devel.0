From: Anders Torger <torger@ludd.luth.se>
Subject: Re: HDSP 9652 sync problems cause loud noise in Alsa 0.9.6
Date: Tue, 7 Oct 2003 09:23:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310070923.35520.torger@ludd.luth.se>
References: <1065480915.3438.17.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1065480915.3438.17.camel@Wizard.knechthome.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I think this problem is related to what I mailed about a week ago (no 
reply). An HDSP master/slave sync problem in current CVS. Thus you are 
not alone with this type of problem.

On Tuesday 07 October 2003 00.55, Mark Knecht wrote:
> Hi,
>    I have a pretty frustrating problem with my Alsa setup. Right now
> I'm just looking for guidance about what's messed up and how I might
> get it fixed. I'm not sure if it's a driver issue, an Alsa issue, or
> a hardware issue. I have not yet found anyone else that has this
> exact set of problems, but no one uses the same hardware either.
>
>    At the outset, let me say that the machine is dual boot and the
> problem does not occur in Windows.
>
> MY SYSTEM - HDSP 9652, Gentoo-2.4.20-r7, Alsa 0.9.6 patched with
> Thomas's HDSP patches from 8/27. ADAT1 out goes to an Alesis AI-3
> D/A.
>
> PROBLEM STATEMENT- When playing mp3's using mpg123 I get a horrible,
> loud and ugly high pitched static noise just before the audio starts
> to play. It lasts about 1 second. I have also noticed that using
> hdspconf to change the sample clock rate to 48K from 44.1K causes the
> same horrible noise, but usually for a shorter period of time.
>
>    One thing I've noticed by watching hdspconf is that when I start
> playing the mp3 that hdspconf first says it loses sync, then goes to
> a lock condition, and then goes back to a sync condition when the
> noise stops. Also the sample frequency changes first to 32KHz and
> then back to 44.1K and then becomes synced again. This happens while
> the noise is occurring.
>
>    My speakers and headphones are driven from an AI-3 converter
> hooked to to the ADAT1 port of the HDSP 9652. The AI-3 is ADAT, based
> but runs at 48K unless it receives a input clock of a different
> frequency. The 9652 is set up to generate 44.1K as the master device,
> and the AI-3 seems to track it except when this noise occurs.
>
>    One last thing. If I set my HDSP 9652 to 48KHz and attempt to play
> and mp3, then the noise occurs, the frequency drops first to 32K And
> then goes to 44.1K. The mp3 plays, but the card is left at 44.1K And
> never goes back to 48K. Does this sound correct?
>
>    I've tried all sorts of different clocking schemes but none of
> them seem to solve this problem.
>
>    I'm hoping that someone in the Alsa-Dev group will know something
> about this and how I might fix it. If you want more technical data or
> have some test you think I should try please let me know.
>
> Thanks in advance,
> Mark
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
