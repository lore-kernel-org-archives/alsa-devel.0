From: "Brian Hinz" <bphinz@hotmail.com>
Subject: ALSA bug 0002948
Date: Mon, 03 Sep 2007 17:31:40 -0400
Message-ID: <BAY105-F342F7BC630ACB6984CEB53C8C90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s24.bay0.hotmail.com (bay0-omc3-s24.bay0.hotmail.com
	[65.54.246.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F0B01037EB
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 23:31:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'll apologize up front if this post seems a little incoherent, I've been 
trying to find a solution to this bug for a few months now and this is sort 
of a collection of observations that I've made and I'm hoping someone might 
read this and a light will go on...

The problem is no sound from a stac9200 on various gateway models, although 
it's possible to get sound from the mic port, never from the hp or internal 
stereo speakers. I recently used a windows utility called "regmon" to log 
the registry events that occurred during a jack cycle on the hp port. I 
expected to see something like this:

...
stsystra.exe:2380 SetValue 
HKLM\Software\Sigmatel\GlobalState\STSysTray\1.0\JackPresenced SUCCESS 0x0
...

indicating an event on port D, but instead got:

...
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRatio 
SUCCESS 0xC8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompAttack 
SUCCESS 0x26B6
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRelease 
SUCCESS 0x26B6
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompThreshDb 
SUCCESS 0xFFFFFDA8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\MakeupGainDB 
SUCCESS 0xC8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRatio 
SUCCESS 0x258
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateAttack 
SUCCESS 0x2706
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRelease 
SUCCESS 0x2706
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateThreshDb 
SUCCESS 0xFFFFDCD8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\Flags 
SUCCESS 0x9
...
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRatio 
SUCCESS 0xE74
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompAttack 
SUCCESS 0x26AC
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRelease 
SUCCESS 0x26AC
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompThreshDb 
SUCCESS 0x0
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\MakeupGainDB 
SUCCESS 0x0
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRatio 
SUCCESS 0x64
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateAttack 
SUCCESS 0x2328
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRelease 
SUCCESS 0x2328
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateThreshDb 
SUCCESS 0xFFFFDCD8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\Flags 
SUCCESS 0xB
...

and upon removal:

...
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRatio 
SUCCESS 0xC8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompAttack 
SUCCESS 0x26B6
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompRelease 
SUCCESS 0x26B6
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\CompThreshDb 
SUCCESS 0xFFFFFDA8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\MakeupGainDB 
SUCCESS 0xC8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRatio 
SUCCESS 0x258
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateAttack 
SUCCESS 0x2706
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateRelease 
SUCCESS 0x2706
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\GateThreshDb 
SUCCESS 0xFFFFDCD8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Compressor\Flags 
SUCCESS 0x8
...
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRatio 
SUCCESS 0xE74
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompAttack 
SUCCESS 0x26AC
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompRelease 
SUCCESS 0x26AC
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\CompThreshDb 
SUCCESS 0x0
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\MakeupGainDB 
SUCCESS 0x0
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRatio 
SUCCESS 0x64
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateAttack 
SUCCESS 0x2328
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateRelease 
SUCCESS 0x2328
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\GateThreshDb 
SUCCESS 0xFFFFDCD8
SetValue 
HKLM\System\CurrentControlSet\Control\Class\{4D36E96C-E325-11CE-BFC1-08002BE10318}\0005\Settings\filter\Rear\Presets\_Initial\Render\Limiter\Flags 
SUCCESS 0xA
...

Notice how the "Flags" key changes?  I don't understand much of this, but it 
seems like the output is being manipulated via digital post-processing 
rather than re-tasking of the analog pin widgets.  I had also been trying to 
make sense of the following line in the windows driver file:

InitVerbs: 03, a0, 45, 01;

which I'd guessed earlier could be interpreted as verb 0x3a0 and payload of 
0x4501, (amplifier gain/mute, set input amp, port B(?), unmute, gain step 1) 
which actually makes some sense in this context, since if the flags key is 
referencing pin widgets the input mux should be unmuted if it's to be used 
as the limiter.

So if I'm actually on the right track here, how would something like this be 
implemented in ALSA? Via /etc/asoundrc?  I tried setting the digital mixer 
as the default pcm device and now the gnome-volume-applet shows the device 
as being muted, and is unable to unmute it.  Nothing is muted in alsamixer 
though, so I'm guessing that I didn't do this correctly in any event.

Another potentially interesting observation is that in the windows sound 
control options there is both a master volume control and a "Wave" volume 
control which seem to be bound together somehow even though they are 
independent controls.  ie: the wave control appears to have the exact same 
function as the master volume.

Lastly, the system beep (which for what it's worth "sounds digital" to my 
untrained ears), works prior to the snd-hda-intel module being loaded, but 
not afterwards, even when unloaded.  Is there any debugging code aready in 
alsa that would produce a copy of /proc/asound/card0/codec#0 prior to any 
codec initialization?

If anyone can make some suggestions I'd be quite grateful.  Also, if there 
is any specific debugging results you'd like to see let me know and I'll 
append them to the bug report.

Thanks,
-brian
