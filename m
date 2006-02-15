From: Rimas Kudelis <rq@akl.lt>
Subject: Re: "test" models in Intel HDA (and probably some other drivers)
Date: Wed, 15 Feb 2006 14:27:38 +0200
Message-ID: <43F31E3A.5050302@akl.lt>
References: <43F2DA9F.8000709@akl.lt> <s5hk6bwao9u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk6bwao9u.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi again,

>> The problem I see here is that those "test" models are only available as
>> a debug feature, which is compiled into the driver only when 
>> CONFIG_SND_DEBUG is defined. I think it would be much more useful to
>> always enable them. On one hand, this wouldn't get in anybody's way, if
>> you don't want it (i.e. you would simply never autodetect this model),
>> while on the other hand, you could just as easily make this model the
>> default for laptops (everything is up to your policy). And in case you
>> wouldn't want to clutter the mixer interface by default, this "test"
>> model would still silently be available for people like me, having
>> absolute silence with all the other configs. This is what is currently
>> happening with many Acer laptop users around the world.
>>
>> Jonathan Woithe said he supports my idea. Takashi, what's your opinion
>> about it? Would you commit a patch fixing this problem to the CVS?
>>     
>
> The test model exists clearly for the debugging purpose.  If only this
> model can bring your device sounds, it means that you need debug
> anyway.  In other words, the test model is not a solution but a method
> to find a solution.
>   

That's right, but there's a problem - you cannot find all solutions
yourself in this case. You need more people for that. IMHO, the more
people will have access to the method to find a solution, the more
solutions you'll get. Isn't that a right thing? Especially when, as I
said, the presence and availability of the "test" model wouldn't really
get in anyones way. It would not even clutter kernel logs.

OTOH, what is the default model now? HP? Fujitsu? Their subset? IMHO, a
reasonable superset should be the default for unknown models, not the
other way round. And "reasonable" means "based on many different brands
and models" in this case. Just "HP, IBM and Fujitsu" is not enough, as
you can see.

Don't forget that there are many people around who aren't Linux geeks,
and they don't know how to (or simply are afraid/don't want to) compile
kernel drivers. If we want more Linux on desktops, we should make sure
Linux is friendly enough for people like them.
> So, basically I disagree with changing it.
>   

Please consider it once more... It *won't* get in anyones way.

regards,
Rimas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
