From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Intel HDA & Realtek issues on ASUS G751JM
Date: Mon, 8 Jun 2015 19:05:44 +0300
Message-ID: <CAH=tA9HdRbRrLrKW+OeYUibjs3StwmKOUD_6p=WMu5LDK4VYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I can't get 4.0/5.1 sound working on my laptop [0] [1] with Fedora 22.
With Linux 4.0 there is no output on jacks but with 4.1-rc6 I'm
getting sound only on one output.
Switching between
pacmd set-card-profile alsa_card.pci-0000_00_1b.0 output:analog-stereo and
pacmd set-card-profile alsa_card.pci-0000_00_1b.0
output:analog-surround-40 only boosts the volume on the first output.

Attached is dmesg [2], lsmod [3], result of lspci -vv [4] and pacmd
list-cards and
list-sinks [5] and output of various information from /proc/asound while
runnig 4.1-rc6.

Let me know if you need more information or how I can help.

Best regards,
Nicolae Rosia

[rosia@localhost ~]$ cat /proc/asound/devices
  1:        : sequencer
  2: [ 0]   : control
  3: [ 0- 3]: digital audio playback
  4: [ 0- 7]: digital audio playback
  5: [ 0- 8]: digital audio playback
  6: [ 0- 0]: hardware dependent
  7: [ 1]   : control
  8: [ 1- 0]: digital audio playback
  9: [ 1- 0]: digital audio capture
 10: [ 1- 1]: digital audio playback
 11: [ 1- 0]: hardware dependent
 33:        : timer
[rosia@localhost ~]$ cat /proc/asound/cards
 0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xeda14000 irq 33
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xeda10000 irq 32
[rosia@localhost ~]$ cat /proc/asound/modules
 0 snd_hda_intel
 1 snd_hda_intel
[rosia@localhost ~]$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version
k4.1.0-0.rc6.git2.1.fc23.x86_64.

[0] http://www.emag.ro/laptop-gaming-asus-cu-procesor-intelr-coretm-i7-4710hq-2-50ghz-haswelltm-17-3-full-hd-touch-screen-24gb-2tb-256gb-ssd-dvd-rw-nvidia-geforce-gtx-860m-2gb-microsoft-windows-8-1-black-g751jm-t3044h/pd/DKK4WBBBM/
[1] https://www.asus.com/Notebooks_Ultrabooks/ASUS_ROG_G751JM/specifications/
[2] http://pastebin.com/rm3dPPYm
[3] http://pastebin.com/gHZWjgBx
[4] http://pastebin.com/UUf91Q31
[5] http://pastebin.com/ca5dcxy8
