From: Steve deRosier <derosier@pianodisc.com>
Subject: No sound with ladspa plugin in newer alsa versions
Date: Mon, 15 Sep 2003 11:20:48 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F660300.3000901@pianodisc.com>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

All,

I hope that someone here can help with a problem we're having with the 
newer versions of the alsa-lib.  We are using the ladspa interface with 
alsa to use a pitch-shifting plugin.  It worked fine with earlier 
versions of the alsa lib, but with the newer versions it produces no 
sound output.  The last version of alsa that we know works (and is the 
"stable" version we're using in our system at the moment because of it) 
is 0.9.0rc6.  Shortly after this version, the ladspa stuff was broken 
(segfault, see the thread starting with:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg07847.html
).  The segfault was fixed, but we've not been able to get audio out of 
alsa-lib when using the plugin since.

I've been trying to track this down, but I'm out of ideas of what/where 
to fiddle with.  We really want to move to more current versions of 
alsa, as working with out-of-date versions is causing us other 
headaches, but we can't till we fix this problem.

One interesting thing...alsa uses an older version of the ladspa.h 
header.  Replaced w/ a more current version and no change though.

I've played with our configuration in asound.conf and no joy.  I've 
examined the code in src/pcm/pcm_ladspa.c and nothing pops up at me. 
I'm currently looking at the source for the plugin, but nothing obvious 
is showing itself.

I'd be happy to fix this myself (or get a patch from someone), but I'm 
out of ideas of where to look or even how to go about debugging this 
particular problem.  Maybe it's a configuration problem;  Maybe a 
problem with pcm_ladspa.c;  Maybe a problem with something else that 
just happened to change around that time.  Any ideas of where I can look 
or how I can debug this issue?

Last known working version: 0.9.0rc6
Currently working with: 0.9.6 and a cvs snapshot from last Thursday 
(broken in both)

Plugin is from:
http://plugin.org.uk/releases/0.4.2/

In our snd_pcm_open call, our device is:
"plug:pd"

The plugin we're using is:
/lib/ladspa/am_pitchshift_1433.so

our asound.conf file looks like:
pcm.pd
{
    type ladspa
    slave.pcm "plughw:0,0"
    path "/lib/ladspa"
    plugins
    [
       {
          label amPitchshift
          input
          {
             controls [ 1.189207 3 ]
          }
       }
    ]
}

Thanks,
- Steve




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
