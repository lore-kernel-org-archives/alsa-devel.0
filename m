From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: No sound with ladspa plugin in newer alsa versions
Date: Mon, 22 Sep 2003 11:43:51 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6F42E7.3060103@pianodisc.com>
References: <3F660300.3000901@pianodisc.com>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F660300.3000901@pianodisc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well, after getting no responses, I've spent the last 40 some hours at 
work tracking the problem down.  I've got some more information and some 
more specific questions so someone might be able to help this time.

I've managed to narrow down the problem with ladspa plugins.  Since it 
used to work, but doesn't any more I figured if I could find the 
specific change I would be able to get an idea where to look to fix the 
problem.  I checked out 20 some CVS versions, built and patched them as 
necessary to get things working and found that the ladspa plugins were 
broken on 2/4/2003.  CVS of 2003-02-04 at midnight worked, but CVS of 
2003-02-05 didn't.  After diffing and then replacing new code with old 
on a change by change basis, I found that snd_pcm_plugin_mmap() and 
snd_pcm_plugin_munmap() in alsa-lib/src/pcm/pcm_plugin.c were stubbed 
out and marked ATTRIBUTE_UNUSED (aparently durring some of perex's DMix 
plugin changes).  Problem is, pcm_ladspa.c and others seem to still use 
these functions.  Adding these functions back into my checked out cvs 
2/5/2003 version and ladspa plugins magically start working again.

But, alas, things are not this easy.  I took my src copy of the 0.9.6 
release (I can't seem to get a current CVS to compile, it complains 
about a missing alsa-lib/src/userfile.c file) and put the functions back 
in (added the meat and removed the attribute), compiled and tested.  I 
now get sound out but it's all garbled.

After looking a bit at pcm_ladspa.c and doing a few greps I found or 
infered that:
1. many of the pcm_{plugintype file here}.c files in there snd_pcm_ops_t 
structure variable they set the mmap and munmap fields still use this 
"ATTRIBUTE_UNUSED" function. Line 710 in pcm_ladspa.c.
2. DMix uses it's own version of these functions.
3. I'm infering that since just putting this function back in doesn't 
work, that something fundamental has changed with the mmap implmentation 
that makes it so the old functions don't work.

I'm guessing that sometime since Feb., there's been some archetectural 
changes to some of the plugin stuff to get DMix working.  But, the other 
portions, including ladspa support, haven't kept up with the changes 
made and so are broken (am I the ONLY person trying to get ladspa 
plugins working with Alsa?).  I'd like to get this fixed.  I'm perfectly 
happy to do the work myself, but I don't know enough of how Alsa works 
in order to get this done.

Here's what I understand: I'm getting the idea that each plugin type, 
when it is parsed in the config file, gets setup.  I presume that the 
_snd_pcm_ladspa_open() function is the entry point for the ladspa stuff. 
  It opens and does some stuff then it uses the snd_pcm_ops_t structure 
to tell the pcm stuff what functions to call in order to get things done 
when working with this plugin.  Kinda a OOP without C++ concept with the 
pcm_ladspa.c module as the "ladspa plugin handler object".  Origionally 
it seems that the pcm_plugin.c module was to provide the basic 
functionality for all the plugins, and then pcm_ladspa.c could override 
or use those functions in it's snd_pcm_ops_t as it needed to.

So, if I was to fix this, I see two potential courses of action:
1. I can put meat back into the snd_pcm_plugin_mmap() ..._munmap() 
functions and then fix it to make it work with the newer stuff so that I 
both get sound out and it comes out properly.
2. I can create my own snd_pcm_ladspa_mmap() and ..._munmap() functions 
and use those.

In either situation, I don't have a clue what I need to put in these 
functions to make them work.  Or even how they really fit into the 
structure of how things work with the pcm system.  I don't know enough 
about Alsa internals to hack this easily (though I'm finding I'm quickly 
being forced to learn).

So, can someone either fix this for me
or,
please educate me enough on what I need to do to make this work so I can 
fix it myself and give you guys a patch.

Help, please!?!?

Thanks,
- Steve


Steve deRosier wrote:
> All,
> 
> I hope that someone here can help with a problem we're having with the 
> newer versions of the alsa-lib.  We are using the ladspa interface with 
> alsa to use a pitch-shifting plugin.  It worked fine with earlier 
> versions of the alsa lib, but with the newer versions it produces no 
> sound output.  The last version of alsa that we know works (and is the 
> "stable" version we're using in our system at the moment because of it) 
> is 0.9.0rc6.  Shortly after this version, the ladspa stuff was broken 
> (segfault, see the thread starting with:
> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg07847.html
> ).  The segfault was fixed, but we've not been able to get audio out of 
> alsa-lib when using the plugin since.
> 
> I've been trying to track this down, but I'm out of ideas of what/where 
> to fiddle with.  We really want to move to more current versions of 
> alsa, as working with out-of-date versions is causing us other 
> headaches, but we can't till we fix this problem.
> 
> One interesting thing...alsa uses an older version of the ladspa.h 
> header.  Replaced w/ a more current version and no change though.
> 
> I've played with our configuration in asound.conf and no joy.  I've 
> examined the code in src/pcm/pcm_ladspa.c and nothing pops up at me. I'm 
> currently looking at the source for the plugin, but nothing obvious is 
> showing itself.
> 
> I'd be happy to fix this myself (or get a patch from someone), but I'm 
> out of ideas of where to look or even how to go about debugging this 
> particular problem.  Maybe it's a configuration problem;  Maybe a 
> problem with pcm_ladspa.c;  Maybe a problem with something else that 
> just happened to change around that time.  Any ideas of where I can look 
> or how I can debug this issue?
> 
> Last known working version: 0.9.0rc6
> Currently working with: 0.9.6 and a cvs snapshot from last Thursday 
> (broken in both)
> 
> Plugin is from:
> http://plugin.org.uk/releases/0.4.2/
> 
> In our snd_pcm_open call, our device is:
> "plug:pd"
> 
> The plugin we're using is:
> /lib/ladspa/am_pitchshift_1433.so
> 
> our asound.conf file looks like:
> pcm.pd
> {
>    type ladspa
>    slave.pcm "plughw:0,0"
>    path "/lib/ladspa"
>    plugins
>    [
>       {
>          label amPitchshift
>          input
>          {
>             controls [ 1.189207 3 ]
>          }
>       }
>    ]
> }
> 
> Thanks,
> - Steve
> 
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
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
