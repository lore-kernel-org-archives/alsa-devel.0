From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: Status of ALSA documentation?
Date: Mon, 25 Feb 2002 20:53:20 -0800 (PST)
Message-ID: <20020226045320.EF0EB2755@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Paul Davis <pbd@Op.Net> wrote:
>>On Tue, 19 Feb 2002, Patrick Shirkey wrote:
>>
>>> I have just uploaded a template for the idea PD had to make a complete
>>> howto for each card and link it to the sound card matrix or something
>>> similar.
>>[...]
>>> http://www.boosthardware.com/LAU/alsa/template2.html
>
>looks OK. a few nitpicks:
>
>  1) don't point people at /lib/modules ... the structure of this
>      tree is different in 2.0, 2.2 and 2.4

Ok I can give the command to load the soundcore module instead. 

eg. modrobe soundcore

>  2) don't put a reference to alsamixer in the template; some cards
>      have no mixer and so it won't do anything useful

I could add that some cards don't use it and provide a link to an amixer howto.

>  3) don't assume that they use vi(1)

Well it is the most popular unix editor. It is just an example for new users who may not even know how to edit a file.

>  4) defining the card name to be of type "hw" might not
>       be too smart for naive "consumer" users who
>       then try to use any old app with that as the PCM
>       device name.
>

This is still fuzzy for me. Should I replace that with "hwshare"? I have started writing a more complete .asoundrc document but haven't finished it yet.

>more generally, it doesn't seem useful to me to duplicate the
>instructions for building+installing+configuring ALSA for each
>card. isn't this what hyperlinks are for? what we need on a per-card
>basis is the stuff thats really specific for that card:
> 

I'm only thinking of LCD. People who may get confused by following links. The easier Linux is for these people the more chance we have of getting hardware working.

> * what modules to load  
> * what module parameters the driver takes
> * a lot of explanation about what they do
> * a list of every Control and PCM switch
> * a lot of explanation about what they do
> * a "FAQ" detailing things like:
>      - how to get sound from the rear speakers?
>      - how to download firmware?
>      - how to get new sounds from the synth?
>      - how to make the synth work?
>      - why do i have to preload module XXX?
>
>>> http://www.boosthardware.com/LAU/alsa/
>
>doesn't render under netscape 4.0
>

You could try.

http://www.boosthardware.com/LAU/alsa/index.html

Otherwise it's windohs or bpftp that are corrupting the files somewhere.

>I think that simply for working on this, Patrick should be made
>webmaster for alsa-project.org. The simple fact that he has bothered
>to do some work on the website moves him beyond almost anybody else on
>the list, though in most cases, for all the right reasons.
>

Sure. At least I have my computers now so can work on things at home. Unfortunately I haven't got net connected yet.

>--p


--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/Linux_Audio_Users_Guide/



_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
You deserve a better email address! Get personalized email @yourname
or @yourcompany from Everyone.net --> http://www.everyone.net?tag

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
