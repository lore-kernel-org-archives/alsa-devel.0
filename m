From: Oliver Schinagl <oliver@schinagl.nl>
Subject: Re: different between "default" and "hw:0,0"?
Date: Tue, 28 Nov 2006 17:57:39 +0100
Message-ID: <456C6A83.4090709@schinagl.nl>
References: <BAY127-W126B9E39CB4FA3B9ED5A58C9E50@phx.gbl>
	<1164730102.29695.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1164730102.29695.57.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This would only apply to the PCM/data side of Alsa right? Not the 
control/mixer part, as from what I gatherd from the alsa wiki, 'default' 
is just a name for card 0.

Other than that, how can I still use software mixing, but force an 
application to use hw1 instead of hw0?

Lee Revell wrote:
> On Tue, 2006-11-28 at 13:26 +0800,  wrote:
>   
>> Hi all,
>> I'm new to alsa, and get some confused with "default" device and and the
>> "hw:0,0" device, do they have any difference?
>> i write a very simple media player app, using xine-lib, i modify the
>> xine config file, set the "audio.device.alsa_front_device" value to
>> "hw:0,0". 
>> i found that, when the value is "hw:0,0", the program can NOT run more
>> than one process at same time(I mean only one process can play
>> sound,others hang),
>> when the value set to "default", i can run more than one process, and
>> every app can play sound at same time.
>> so, it seems that, the "default" and he "hw0,0" are not same, and i
>> don't know the detail.
>>     
>
> Using the hw device bypasses ALSA's software mixing layer and thus only
> one app can play at a time.  Apps should always use "default" unless you
> know what you are doing.
>
> Lee
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>   

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
