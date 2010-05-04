From: "Andreas Falkenhahn" <andreas@airsoftsoftwair.de>
Subject: Re: Playing multiple sounds at the same time
Date: Tue, 04 May 2010 10:23:00 +0200
Message-ID: <201005041023000453.00054B97@127.0.0.1>
References: <4411e1854e5de844b0cf28262efd5992-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFJQQ1lcLkQAWFhfQltcWgE=-webmailer2@server02.webmailer.hosteurope.de>
	<20100430104308.GE21607@sirena.org.uk>
	<h2u4f3252891005031934h2a950ac4z1e9036738c88e27e@mail.gmail.com>
Reply-To: andreas@airsoftsoftwair.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp006.webpack.hosteurope.de (wp006.webpack.hosteurope.de
	[80.237.132.13]) by alsa0.perex.cz (Postfix) with ESMTP id 0D54824522
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 10:23:22 +0200 (CEST)
In-Reply-To: <h2u4f3252891005031934h2a950ac4z1e9036738c88e27e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04.05.2010 at 10:34 Raymond Yau wrote:

>2010/4/30 Mark Brown <broonie@opensource.wolfsonmicro.com>
>
>> On Fri, Apr 30, 2010 at 12:38:49PM +0200, Andreas Falkenhahn wrote:
>>
>> > Now I want to play sounds 1 to 3 at the same time. My question is now:
>> Can
>> > ALSA do automatic mixing for me here or do I have to do the mixing on
>my
>> > own? In other words, can I simply feed all these three sound streams to
>> > ALSA or do I have to mix them into a fourth audio stream first and
>> feeding
>> > this new fourth stream to ALSA then?
>>
>> The easiest thing for your application is to just open and play multiple
>> audio streams and allow a system mixing daemon such as PulseAudio to
>> take care of the mixing.
>>
>>
>Are you sure that your program can connect to PA server multilple times ?

Yes, it's working fine. I can call snd_pcm_open() as many times as I want
and it is playing multiple streams in different sample formats at the same
time just fine.

Greets,

Andreas
--
"Remember: It's nice to be important but it's more important to be nice!"
