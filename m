From: Paul Davis <pbd@Op.Net>
Subject: Re: Status of ALSA documentation?
Date: Tue, 26 Feb 2002 00:17:01 -0500
Message-ID: <200202260517.AAA29389@renoir.op.net>
In-reply-to: Your message of "Mon, 25 Feb 2002 20:53:20 PST."
             <20020226045320.EF0EB2755@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Ok I can give the command to load the soundcore module instead. 
>
>eg. modrobe soundcore

modprobe -n soundcore will test for its existence without doing anything.

>Well it is the most popular unix editor. It is just an example for new users w
>ho may not even know how to edit a file.

pointing them at vi will not help such users. just tell them to edit
the file - if they don't know how to do that, this document can't be
of any help to them, really.

>>  4) defining the card name to be of type "hw" might not
>>       be too smart for naive "consumer" users who
>>       then try to use any old app with that as the PCM
>>       device name.
>>
>
>This is still fuzzy for me. Should I replace that with "hwshare"? I have start
>ed writing a more complete .asoundrc document but haven't finished it yet.

for most people, their most used PCM device will be of type "plug" or
"plughw" (the latter just being a notational convenience rather than
anything truly different).

>>more generally, it doesn't seem useful to me to duplicate the
>>instructions for building+installing+configuring ALSA for each
>>card. isn't this what hyperlinks are for? what we need on a per-card
>>basis is the stuff thats really specific for that card:
>> 
>
>I'm only thinking of LCD. People who may get confused by following links. The 
>easier Linux is for these people the more chance we have of getting hardware w
>orking.

The problem is that these documents will become reference sheets for
each soundcard. Browsing through a couple of pages of install info for
ALSA every time you want to check on that detail about the
CmRMiceCreatEmu Y18kJA card is going to annoy most people. 

>>>> http://www.boosthardware.com/LAU/alsa/
>>
>>doesn't render under netscape 4.0
>>
>
>You could try.
>
>http://www.boosthardware.com/LAU/alsa/index.html
>
>Otherwise it's windohs or bpftp that are corrupting the files somewhere.

same deal. i get the page source, it looks OK, but doesn't render.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
