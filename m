From: Antonio Willy Malara <behappy@maialone.com>
Subject: Re: usb-audio
Date: Mon, 27 Oct 2003 20:53:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031027195308.GA5219@Zeryn>
References: <20031027180300.GA5016@Zeryn> <s5hptgi5yx4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hptgi5yx4.wl@alsa2.suse.de>; from tiwai@suse.de on lun, ott 27, 2003 at 19:16:23 +0100
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

On 2003.10.27 19:16, Takashi Iwai wrote:
> > 	/* FIXME: correct endianess and sign? */
> could you give more information:
> which program, which device and what format doesn't it work?

the system is a powermac, the device is a Griffin iMic, the app is jack 
version 0.80, the output is:

Sorry. The audio interface "hw:1"doesn't support either of the two 
hardware sample formats that jack can use.

that is raised from here (sorry for the wordwrap):

         if ((err = snd_pcm_hw_params_set_format (handle, hw_params, 
SND_PCM_FORMAT_S32)) < 0) {
                 if ((err = snd_pcm_hw_params_set_format (handle, 
hw_params, SND_PCM_FORMAT_S16)) < 0) {
                         jack_error ("Sorry. The audio interface \"%s\""
                                     "doesn't support either of the two 
hardware sample formats that jack can use.",
                                     device_name);
                         return -1;
                 }
         }

(/drivers/alsa/alsa_driver.c line 293 from the jack 0.80 tree)

i made this test: if i change the SND_PCM_FORMAT_S32 to _S32_LE the app 
goes forward but alsalib will raise many broken pipe errors and got no 
sound

hope this will help

> Takashi

willy


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
