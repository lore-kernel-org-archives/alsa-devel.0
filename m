From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: How to lock the sample rate ?
Date: Sun, 9 May 2004 22:08:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040509220842.0e0a9a2f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On Sat, 6 Mar 2004, Jaroslav Kysela wrote:

>> On the Echoaudio cards the sample rate is a global setting, so I need a way
>> to prevent an app to change the rate if someone else already set it (the
>> card han several devices/subdevices). I was thinking to put a simple
>> "if (IsAudioOpen()) rate_min=rate_max=current_rate;" in pcm_open callback,
>> but this solution is racy.
>
> Yes, but I don't see a better solution for "auto" rate settings.
> Also, it would be probably good to create a control which can "fix" the 
> rate to a value (ICE1712 driver already has this feature).

This is quite a late reply :) There is another solution. It came into mind
while I was writing the weird sample rate rule for the Layla24. Instead of setting
hw.rate_mix and max in the open() callback, I apply a rule like this:

{
	snd_interval_t *rate = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);

	if (atomic_read(&chip->opencount) > 1) {
		snd_interval_any(&fixedrate);
		fixedrate.min = fixedrate.max = currentrate;
		return snd_interval_refine(rate, &fixedrate);
	}
	return 0;
}

It's still racy, but not as much as the other solution. When two apps open a
substream, the first one sets the sample rate and the second one has to use
that rate. Then, if the first app closes the substream, the second one is
allowed to change the rate without the need to close and reopen. Furthermore
the first app cannot change the rate while second app has an open subsream.
The solution is still racy when one app opens more than one substream. There
is also a small race in the window between snd_pcm_open and
snd_pcm_hw_params_set_rate, but it can be fixed easily.

About adding a control which can fix the rate to a value I'm undecided. Yes,
it solves the problem, but it's quite annoying having to switch the rate
manually. I'd prefer something that works more transparently to the user.


--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
