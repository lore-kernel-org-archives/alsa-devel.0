From: Vitaly <chernookiy@yahoo.com>
Subject: aplay have trubles with playback via ladspa plugin
Date: Tue, 22 Aug 2006 13:31:48 -0700 (PDT)
Message-ID: <20060822203148.66432.qmail@web32506.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

$ ~/tmp/alsa-utils-1.0.11/aplay/aplay -D plug:ladspa ~/tmp/TRACK08.wav 
Playing WAVE '/root/tmp/TRACK08.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Stereo 
aplay: set_params:961: Unable to install hw params:Invalid argument 
ACCESS: RW_INTERLEAVED 
FORMAT: S16_LE 
SUBFORMAT: STD 
SAMPLE_BITS: 16 
FRAME_BITS: 32 
CHANNELS: 2 
RATE: NONE 
PERIOD_TIME: (85333 85334) 
PERIOD_SIZE: NONE 
PERIOD_BYTES: (15052 15056) 
PERIODS: (3 4) 
BUFFER_TIME: (341315 341316) 
BUFFER_SIZE: 15052 
BUFFER_BYTES: 60208 
TICK_TIME: 1000 
$

Any ideas?

$ cat /etc/asound.conf 
# an example command is 'aplay -D plug:ladspa <filename>' 
# otherwise, the ladspa plugin expects FLOAT type which 
# is very rare 
pcm.ladspa { 
    type ladspa 
    slave.pcm "plughw:0,0"; 
    path "/usr/local/lib/ladspa/"; 
    plugins [ 
       { 
           id 19001 
           filename "/usr/local/lib/ladspa/dj_eq_19001.so" 
       } 
    ] 
}

$analyseplugin dj_eq_19001

Plugin Name: "DJ EQ (mono)"
Plugin Label: "dj_eq_mono_cvv"
Plugin Unique ID: 19007
Maker: "Steve Harris <steve@plugin.org.uk>"
Copyright: "GPL"
Must Run Real-Time: No
Has activate() Function: Yes
Has deativate() Function: No
Has run_adding() Function: Yes
Environment: Normal or Hard Real-Time
Ports:  "Input" input, audio
        "Output" output, audio
        "latency" output, control

Plugin Name: "DJ EQ"
Plugin Label: "dj_eq_cvv"
Plugin Unique ID: 19001
Maker: "Steve Harris <steve@plugin.org.uk>"
Copyright: "GPL"
Must Run Real-Time: No
Has activate() Function: Yes
Has deativate() Function: No
Has run_adding() Function: Yes
Environment: Normal or Hard Real-Time
Ports:  "Input L" input, audio
        "Input R" input, audio
        "Output L" output, audio
        "Output R" output, audio
        "latency" output, control

$

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
