From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: re.Fix hang in mpu401_uart.c patch
Date: Mon, 15 May 2006 22:45:45 +0100
Message-ID: <200605152245.45507.gineera@aspect135.co.uk>
References: <200605101556.50928.gineera@aspect135.co.uk> <s5hejz03baa.wl%tiwai@suse.de> <200605131304.49711.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200605131304.49711.gineera@aspect135.co.uk>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, jcm@jonmasters.org
List-Id: alsa-devel@alsa-project.org

On Saturday 13 May 2006 13:04, I wrote:
> On Thursday 11 May 2006 15:07, you wrote:
> > At Wed, 10 May 2006 16:10:41 +0100,
> >
> > Alan Horstmann wrote:
> > > This patch since 1.0.11 throws up an underlying problem with au88x0
> > > (separate posting refers), but I also noticed that the 4th hunk applys
> > > changes to snd_mpu401_uart_input_close and
> > > snd_mpu401_uart_output_close.
> > >
> > > However, as the 3rd augument is '0' ie don't check ACK, OK is always
> > > true in snd_mpu401_uart_cmd and there is surely no point to the extra
> > > check lines?
> > >
> > > (As my separate posting 'au88x0_mpu401 init / fail first open'
> > > mentions, ACK is not returned from the RESET during the close, either
> > > with ice1712 or au8820, so can't be checked for.)
> >
> > Which patch are you referring to??
>
> The one titled  'Fix hang in mpu401_uart.c',  on repo about 2 weeks ago, by
> Jon Masters.

Specifically, chunks below:-

Alan

 static int snd_mpu401_uart_input_close(struct snd_rawmidi_substream 
*substream)
 {
 	struct snd_mpu401 *mpu;
+	int err = 0;

 	mpu = substream->rmidi->private_data;
 	clear_bit(MPU401_MODE_BIT_INPUT, &mpu->mode);
 	mpu->substream_input = NULL;
 	if (! test_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode))
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
+		err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
 	if (mpu->close_input)
 		mpu->close_input(mpu);
+	if (err)
+		return -EIO;
 	return 0;
 }

 static int snd_mpu401_uart_output_close(struct snd_rawmidi_substream 
*substream)
 {
 	struct snd_mpu401 *mpu;
+	int err = 0;

 	mpu = substream->rmidi->private_data;
 	clear_bit(MPU401_MODE_BIT_OUTPUT, &mpu->mode);
 	mpu->substream_output = NULL;
 	if (! test_bit(MPU401_MODE_BIT_INPUT, &mpu->mode))
-		snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
+		err = snd_mpu401_uart_cmd(mpu, MPU401_RESET, 0);
 	if (mpu->close_output)
 		mpu->close_output(mpu);
+	if (err)
+		return -EIO;
 	return 0;
 }

@@ -316,6 +339,7 @@ static void snd_mpu401_uart_input_trigge
 			snd_mpu401_uart_remove_timer(mpu, 1);
 		clear_bit(MPU401_MODE_BIT_INPUT_TRIGGER, &mpu->mode);
 	}
+
 }

 /*




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
