From: "John S. Denker" <jsd@monmouth.com>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Thu, 05 Dec 2002 06:39:36 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF3AF8.2050107@monmouth.com>
References: <3DEF2ED7.7000808@monmouth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DEF2ED7.7000808@monmouth.com>
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

     ==== This is a slightly-updated clone of item
     #636948 on the sourceforge bug/patch reporting
     system.  I'm moving it to here (the alsa-devel
     mailing list) at the request of Jaroslav. ====

When talking to Extigy on the USB bus:

    alsactl -f /tmp/foo store
alsactl: get_control:202: Cannot read control'2,0,0,Digital In Playback 
Source,0': Invalid argument
alsactl: get_control:202: Cannot read control '2,0,0,3D Stereo Extender 
Switch,0': Invalid argument
alsactl: get_control:202: Cannot read control '2,0,0,Up Down Switch,0': 
Invalid argument
alsactl: get_control:202: Cannot read control '2,0,0,Up Down Mode 
Select,0': Invalid argument

    alsactl -f /tmp/foo restore
alsactl: set_control:976: Cannot write control '2:0:0:Digital In 
Playback Source:134521100' : Invalid argument
alsactl: set_control:976: Cannot write control '2:0:0:3D Stereo Extender 
Switch:134521100' : Invalid argument
alsactl: set_control:976: Cannot write control '2:0:0:Up Down 
Switch:134521100' : Invalid argument
alsactl: set_control:976: Cannot write control '2:0:0:Up Down Mode 
Select:134521100' : Invalid argument

I modified alsactl to mke the foregoing errors non-fatal. That allowed
me to progress far enough to discover other errors, as reported a few
minutes ago.

Alsamixer also dies with "invalid argument".

I suspect this is a driver bug (as opposed to a utils bug) because I
suspect the driver is misinforming the utils as to what controls it
offers.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
