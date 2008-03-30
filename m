From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 31 Mar 2008 10:11:38 +1300
Message-ID: <2C0A0DF6-7FD6-4444-A485-C0828E40F427@orcon.net.nz>
References: <20080330210759.6B20DDBA2@gherkin.frus.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20080330210759.6B20DDBA2@gherkin.frus.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Bob Tracy <rct@frus.com>
Cc: Rene Herman <rene.herman@keyaccess.nl>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Bob
>> (miata_no_mmap.diff patch)
>
> Made no difference for any of the "sox" tests, and "play" is still
> broken in the way it always has been.  However, "aplay" generated an
> interesting error I haven't seen before:
>
> $ aplay asskickd.wav
> Playing WAVE 'asskickd.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
> ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to  
> find an usable access for 'default'
> aplay: aplay.c:919: set_params: Assertion `err >= 0' failed.

Add in the "-D hw" option to the aplay command when using the mmap  
disabled alsa sound.

Michael.

