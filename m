From: Brad Midgley <bmidgley@xmission.com>
Subject: alsa-lib plugin devel
Date: Mon, 24 Jan 2005 01:17:21 -0700
Message-ID: <41F4AF11.2090109@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

I've started working on an alsa-lib plugin to send audio to a bluetooth 
device (see http://bluetooth-alsa.sf.net)

I stubbed it out so I can see that it gets invoked when I address it 
directly with

	aplay -B 1000000 -D pcm.a2dp sound.wav

And I can see it is invoking the plugin code (just filled in with a 
bunch of printf's). What I'm struggling with is how to make this driver 
appear to clients that use alsa-lib. In the simplest case,

	aplay --list-devices

Does not show my device in its list! So clients that look up alsa 
devices will never see it.

my .asoundrc looks like:

	pcm.a2dpplug {
         	type plug
	        slave { pcm "a2dp" }
	}

	pcm.a2dp {
         	type a2dp
	        bdaddr "00:08:F4:30:05:BB"
	}

and I tried it with and without the first section. How do I get my 
bluetooth device to show up in a device scan?

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
