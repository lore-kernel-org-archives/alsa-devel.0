From: David Lloyd <dmlloyd@tds.net>
Subject: Quake3 and DMIX
Date: Fri, 30 Jan 2004 17:48:52 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401082219001.32519@ultros>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This actually covers (I think) all games based on the Quake3 engine.

So far, my attempts to get these games to work with the alsa dmix plugin 
have met with failure.

This is tha basic dmix config I'm working off of:

pcm.ossmix {
    type dmix
    ipc_key 1024
    slave {
        pcm "hw:0,0"
	rate 22050
	format S16_LE
    }
    bindings {
    	0 0
	1 1
    }
}

This config allows me to use other OSS applications, such as xmms and
teamspeak, without a problem.

Basically, when I start up with this config I get the following message in 
the console:

----- Sound Info -----
sound system is muted
    1 stereo
16536 samples
   16 samplebits
    1 submission_chunk
22050 speed
0x89dffd8 dma buffer

and the sound is either nonexistant or consists of loud popping or
staccato buzzing noises.

Can anyone point me in the right direction?

- D


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
