From: patrick reardon <swpatrick@earthlink.net>
Subject: Hammerfall configuration
Date: Thu, 19 Dec 2002 10:55:30 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E01FA02.D0B4CD44@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

i have an AI-3 connected to the hammerfall's optical in/outs.  the converter will slave to
any clock, but when it's the master clock it only operates at 48K.  when i use "arecord -f
cd <file>" this seems to cause arecord to write 44.1k headers even though the data is at
48K.  "aplay" has no  problem with this (files play back at normal speed), but it seems to
cause problems with other software such as "cdrecord" which burns the files to disk about
2-3 half steps too low.  i tried resampling down to 44.1k with "sox" but it didn't seem to
help (i'm guessing it's also fooled by the 44.1k headers).

i'd like to use the hammerfall's internal clock as the master and let the AI-3 slave to
it, but am having trouble changing the configuration of the card.  i've looked for
documentation about this but so far haven't found any.  i tried editing asound.state 

-----------snip------------
        control.7 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 AutoSync
                comment.item.1 Master
                comment.item.2 'Word Clock'
                iface PCM
                name 'Sync Mode'
                value AutoSync
        }
        control.8 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.item.0 'IEC958 In'
                comment.item.1 'ADAT1 In'
                comment.item.2 'ADAT2 In'
                iface PCM
                name 'Preferred Sync Source'
                value 'ADAT1 In'
------------snip------------

by hand, changing the 'Sync Mode'  value from AutoSync to Master (should these values be
in quotes?), ran "alsactl store hammerfall", unloaded then reloaded the alsa modules, then
ran "alsactl restore hammerfall.  ("hammerfall" is the card's id.)  but asound.state 
still indicates Sync Mode is set to AutoSync.  "vi /proc/asound/hammerfall/rme9652" reads

--------------snip----------------
Latency: 8192 samples (2 periods of 32768 bytes)
Hardware pointer (frames): 0
Passthru: no
Clock mode: autosync
Pref. sync source: ADAT1

IEC958 input: Coaxial
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 Dolby: off
IEC958 sample rate: error flag set

ADAT Sample rate: 48000Hz
ADAT1: No Lock
ADAT2: No Lock
ADAT3: No Lock
--------------snip-----------------



i'm also curious if the "IEC958 sample rate: error flag set" is normal and if not, what to
look at to fix it.  asound.state says

----------snip-----------
        control.10 {
                comment.access read
                comment.type INTEGER
                comment.range '0 - 96000'
                iface PCM
                name 'IEC958 Sample Rate'
                value -1
----------snip-----------


changing the configuration must be a simple affair (i think) but i'm out of ideas.  any
suggestions or a pointer to relevant documentation would be appreciated.  also, if there's
no  documentation on this issue, i'd be glad to write some once i figure it out.  

tia, 
patrick


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
