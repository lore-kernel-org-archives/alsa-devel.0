From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: aplay works but not real player
Date: Fri, 6 Jun 2008 13:19:40 +0530
Message-ID: <827ad74d0806060049u381559bao661ad28746ea2b56@mail.gmail.com>
References: <827ad74d0806050426o787c34eo49432eea5abdeee6@mail.gmail.com>
	<48483123.7050504@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id AAEC424509
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 09:49:49 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so214012and.80
	for <alsa-devel@alsa-project.org>; Fri, 06 Jun 2008 00:49:48 -0700 (PDT)
In-Reply-To: <48483123.7050504@cox.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <ghjeold_i_mwee@cox.net>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I did not try xmms but amarok and kaffine play the files in suse flavour.
But i am still not able to get the real player working. Can anyone help me
what else configuration i have to set for real player to work?

On Fri, Jun 6, 2008 at 12:02 AM, stan <ghjeold_i_mwee@cox.net> wrote:

> Harsha priya gupta wrote:
>
>> I am using .copy function in my driver.
>> aplay playes any .wav file given. When i open real player and try playing
>> it
>> says device is busy.
>> I tried the earlier advice to write the following into ~./asoundrc but
>> does
>> not help
>> pcm.!default{
>> type hw
>> card 0
>> }
>>
>> any clue that can help me ?
>>
>>
>>
> Have you got realaudio configured to use alsa or oss?  If oss, do you have
> package aoss installed,
> the alsa oss emulation layer?  Whatever device it wants to use is
> in use by something else.  A sound server can cause this problem as well.
>
> Try with something like xmms or audacity also.
>
> The fact that aplay can play means this is a configuration issue.
>



-- 
-Harsha
