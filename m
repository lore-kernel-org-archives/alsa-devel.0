From: John Dey <jsdey@optonline.net>
Subject: Re: drop outs with FC8 and latest CCRMA kernel
Date: Fri, 04 Jan 2008 12:58:07 -0500
Message-ID: <0d344f2efe80e13824e3a123d9c269db@optonline.net>
References: <477D8665.7020709@vfemail.net> <200801032104.46296.lowen@pari.edu>
 <695e1a650801040712r3be21a00q4257ef1654f739b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <planetccrma-admin@ccrma.Stanford.EDU>
In-reply-to: <695e1a650801040712r3be21a00q4257ef1654f739b9@mail.gmail.com>
Sender: planetccrma-admin@ccrma.Stanford.EDU
Errors-To: planetccrma-admin@ccrma.Stanford.EDU
List-Help: <mailto:planetccrma-request@ccrma.stanford.edu?subject=help>
List-Post: <mailto:planetccrma@ccrma.stanford.edu>
List-Subscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=subscribe>
List-Unsubscribe: <http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma>,
	<mailto:planetccrma-request@ccrma.stanford.edu?subject=unsubscribe>
List-Archive: <http://ccrma-mail.stanford.edu/pipermail/planetccrma/>
To: Hector Centeno <hcengar@gmail.com>
Cc: Planet ccrma <planetccrma@ccrma.Stanford.EDU>, "D. Michael 'Silvan' McIntyre" <rosegarden.trumpeter@gmail.com>, Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Alsa Dev <alsa-devel@alsa-project.org>, Lamar Owen <lowen@pari.edu>
List-Id: alsa-devel@alsa-project.org

Hector,

I have read your response and can only comment that I have been a user 
of CCRMA's version of Fedora for some time.  I am not responding to 
place my recommendation for that distribution over Ubuntu since I only 
tried Ubuntu early on when it was not stable.  I would like to offer my 
observation on what I have felt for a long time regarding to multimedia 
(sound) on linux.

What has made linux OS so successful is that it has a legion of 
volunteers willing to contribute to the cause of advancing the state of 
the OS for free but even more importantly, in my opinion, is the fact 
that Linus Torvalds has been the leader to keep those volunteers 
motivated while controlling/coordinating the development of the OS.  He 
and others (what were very productive volunteers) have even figured 
ways to make a living at what they have done so well for free.  I am 
unaware of any such  individual (or organization) functioning similarly 
for multimedia-sound).  My reason for choosing CCRMA and staying with 
it is because Fernando Lopez-Lezcano has been available, almost at 
moments notice, to answer and solve most of problems that I have 
encountered. (I don't know how he has the patients and stamina to do 
what he does.)  I do get frustrated that I can not get my ATI graphics 
card to work and have to settle for a less then optimal driver for 
video but my major concern recently, and maybe I am wrong, is the state 
of soundcard drivers available for linux (particularly notebooks).  I 
have had good luck with desktops and m-audio soundcards but with 
notebooks I don't have any comfort that there are cards that fully 
work.  (This comment maybe too harsh.)  Without reliable soundcard 
drivers, I worry that the whole elegant alsa sound system and sound 
applications my never achieve their full potential and may just wither 
and die.

I have heard some of the arguments that vendors have been 
non-cooperative.  I do believe that there should be ways to structure 
an approach that would give the linux/sound community leverage over the 
vendor in order to get their cooperation, e.g. a non-profit 
organization with support from colleges and university music 
departments.  I would like to hear if I am all wet.  However, before we 
get too far into the new year, I had to get these thoughts off my 
chest.  Happy New Year? And thanks to all who contribute.

John Dey

On Jan 4, 2008, at 10:12 AM, Hector Centeno wrote:

> Hi again,
>
>
> On Jan 3, 2008 9:04 PM, Lamar Owen <lowen@pari.edu> wrote:
>> On Thursday 03 January 2008, bH wrote:
>>>  Lamar Owen wrote:
>>
>> The point is, once built for Ubuntu 7.10, it has to be rebuilt for 
>> 8.04, then
>> 8.10 (or whatever), and so on; you don't gain anything going to 
>> Ubuntu, as it
>> is just as fast moving as Fedora is in terms of support; the repo 
>> would still
>> have to be rebuilt every six months, as packages for 7.04 may or may 
>> not work
>> for 7.10 (and packages for 6.06 will definitely not work for 7.10 or 
>> the
>> upcoming 8.04).
>>
>
> I think I disagree about this. You would gain a lot going to Ubuntu
> instead of Fedora. It is true that Ubuntu gets upgraded every 6 months
> (as Fedora does) but in Ubuntu you have the hard work of many people
> trying to make Linux usable and friendly and at the same time to keep
> it up to date, while in Fedora you get a bunch of experimental and
> broken things thrown to the users for beta testing. For instance,
> something like having and ATI graphics card working, with full 3D
> rendering, under Fedora 8 is almost impossible, while in Ubuntu works
> out of the box, or if you want to install the Nvidia drivers in Ubuntu
> you just get them from the repository or better yet, just click on the
> proprietary drivers icon that pops up at the panel bar when it detects
> your Nvidia hardware. I know I could just download the sources and
> compile myself... but well, it saves time to have things planed ahead
> by someone who cares about usability.
>
> Regarding the upgrading issue, I do mind having the latest version of
> Gnome, for example, as it usually means less bugs and better
> usability. As I said before, I think Linux-Audio and
> Linux-as-a-desktop is quite young and in development, you can't really
> get stuck with a buggy and underdeveloped application for too long as
> you might be missing a stabler and more usable system.
>
> Just my thoughts.
>
> Cheers!
>
> Hector
>
>
>
>> But all of that is moot; PlanetCCRMA is currently an RPM repository, 
>> and the
>> effort required for changing to be a Debian repository is significant;
>> probably a lot harder than keeping up with Fedora (this is something 
>> I know a
>> little bit about; I packaged PostgreSQL RPM's for Red Hat Linux and 
>> Fedora
>> from 1999 up through 2004; I investigated Debian packaging, and it is 
>> very
>> very different from RPM packaging.  Now, nando is a very bright 
>> fellow; I
>> have no doubts he is capable to doing that.  The bigger question is 
>> whether
>> he wants to do so.
>>
>
>
>
>
>> Further, there are already Debian packagers for some of this; you 
>> should
>> really talk to them about updating their versions, rather than muddy 
>> the
>> currently well-unified repository waters for Ubuntu.  That is really 
>> the
>> major advantage over Fedora that Ubuntu has; Fedora's repositories 
>> have
>> historically been somewhat fractured.
>>
>> However, there is work ongoing to merge PlanetCCRMA RPM's into Fedora 
>> itself,
>> which would lessen nando's work load.  This I'm sure he looks forward 
>> to!
>>
>> Now, the latency could be due to other things set up in the 
>> PlanetCCRMA kernel
>> and other libs versus the Ubuntu linux-rt kernel; don't know.  It 
>> would be
>> interesting to see what the .config for the Ubuntu rt kernel looks 
>> like
>> versus the PlanetCCRMA one.
>>
>> I myself am having issues with the F8 PlanetCCRMA rt kernel; I'm 
>> running F7 on
>> my main DAW desktop for now, but will be upgrading probably next 
>> week, as
>> things are stable enough at this point for my uses.  I'll probably 
>> forgo the
>> rt kernel for now, as my uses currently don't require the low latency.
>>
>> I for one am thrilled with what nando has been doing for the last 
>> several
>> years; many thanks, nando!
>> --
>>
>> Lamar Owen
>> Chief Information Officer
>> Pisgah Astronomical Research Institute
>> 1 PARI Drive
>> Rosman, NC  28772
>> (828)862-5554
>> www.pari.edu
>>
>> _______________________________________________
>> PlanetCCRMA mailing list
>> PlanetCCRMA@ccrma.stanford.edu
>> http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma
>>
>
> _______________________________________________
> PlanetCCRMA mailing list
> PlanetCCRMA@ccrma.stanford.edu
> http://ccrma-mail.stanford.edu/mailman/listinfo/planetccrma
>
