From: Mark Knecht <markknecht@comcast.net>
Subject: Wine failures with Alsa 1.0.0rc1
Date: Thu, 04 Dec 2003 04:56:00 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070542560.2085.23.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

** Thu Dec  4 04:41:38 2003
Starting '/opt/cxoffice/bin/wineloader' '--'
'winepath.exe' '--long' '--'
'/home/mark/.cxoffice/dotwine/fake_windows/SIERRA/CAESAR3DEMO/c3.exe'

Argument conversion:
  [/home/mark/.cxoffice/dotwine/fake_windows/SIERRA/CAESAR3DEMO/c3.exe]
-> [C:\SIERRA\CAESAR3DEMO\c3.exe]
Command:
/opt/cxoffice/bin/wineloader winewrapper.exe cxoffice --
C:\SIERRA\CAESAR3DEMO\c3.exe

** Thu Dec  4 04:41:38 2003
Starting '/opt/cxoffice/bin/wineloader' 'winewrapper.exe' 'cxoffice'
'--'
'C:\SIERRA\CAESAR3DEMO\c3.exe'

fixme:imm:ImmAssociateContext ((nil), 0x404c3350): semi-stub
fixme:imm:ImmAssociateContext ((nil), 0x404c2e20): semi-stub
fixme:imm:ImmAssociateContext ((nil), 0x40502838): semi-stub
err:module:BUILTIN32_LoadLibraryExA failed to load .so lib for builtin
winealsa.drv: /opt/cxoffice/lib/wine/winealsa.drv.so: undefined symbol:
snd_pcm_playback_drain
err:module:NE_LoadBuiltinModule failed to load .so lib for 16-bit
builtin winealsa.drv: /opt/cxoffice/lib/wine/winealsa.drv.so: undefined
symbol: snd_pcm_playback_drain
bash-2.05b$ 



>From the Wine config file:

; Uncomment the "Drivers" line matching your sound setting.

;"Drivers" = "wineoss.drv"      ; default for most common configurations
;"Drivers" = "winearts.drv"    ; for KDE
"Drivers" = "winealsa.drv"    ; for ALSA users
;"Drivers" = "winejack.drv"    ; for Jack sound server
;"Drivers" = "winenas.drv"     ; for NAS sound system
;"Drivers" = "wineaudioio.drv" ; for Solaris machines
;"Drivers" = ""                ; to disable sound
"WaveMapper" = "msacm.drv"
"MidiMapper" = "midimap.drv"




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
