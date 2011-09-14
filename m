From: "Sebastian H." <vand2-Mmb7MZpHnFY@public.gmane.org>
Subject: [LAD] QasMixer 0.13.0 released
Date: Wed, 14 Sep 2011 14:53:22 +0200
Message-ID: <4E70A3C2.3070607@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, qtdesktop-devel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

QasMixer version 0.13.0 is now available.

QasMixer is an ALSA mixer with a customized Qt GUI.

Changes:

* Minimize to tray removed - fixes disappearing issue in Gnome
* Balloon style tweaks
* Balloon closes on click
* Balloon icon recognizes wheel events (changes the volume)
* Mouse over tray icon raises the balloon
* View type toolbar changed to tab selection
* Playback/capture toolbar buttons moved to the bottom switches area
* Improved widget focus restoring after a channel join/split
* Device selection reflects the actual ALSA tree
* Simplified settings dialog
* Mixer window restores its former size on startup
* Overhauled widget painting now uses Cairo (http://cairographics.org)
* Multithreaded widget painting (if cairo version supports it)
* More graphics reuse for a smaller memory footprint

Homepage with more information
http://xwmw.org/qasmixer

Project page
http://sourceforge.net/projects/qasmixer/


Happy volume changing!

--
Sebastian Holtermann
