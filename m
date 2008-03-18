From: "Bouterse, Bob" <bob.bouterse@dm-holdings-na.com>
Subject: Having a fight with
	snd_sctl_install:src/control/setup.c in alsa-lib-1.0.14a
Date: Tue, 18 Mar 2008 11:32:13 -0400
Message-ID: <6601CF63C167F44A9A9E97E41EE4B16C63BC3C@CLUSTEREX.corporate.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p01c11o141.mxlogic.net (p01c11o141.mxlogic.net [208.65.144.64])
	by alsa0.perex.cz (Postfix) with ESMTP id E7AA424438
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 16:32:20 +0100 (CET)
Content-class: urn:content-classes:message
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

I am using alsa-lib-1.0.14a on a VIA EPIA 15000g board.

I am hoping that someone can help me. I have been in an entrenched fight
with the sctl functions setting my ctl setting back to the config file
values.

I am working on some extensions to the alsa audio output plugins in xine
to provide simultaneous analog and iec958 on a Via EPIA 15000g, board.

The issue is that I need to set the iec958 status bits at runtime, but
everytime I call:

/*----------------------------------------------------------------------
-----*/
	...

	snd_ctl_elem_value_get_iec958(cval, &iec958);
	llprintf(LOG_MIXER,"Read
AES0=0x%02x,AES1=0x%02x,AES2=0x%02x,AES3=0x%02x\n",
		   iec958.status[0], iec958.status[1], iec958.status[2],
iec958.status[3]);

	/* AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2 */
	iec958.status[0] = IEC958_AES0_NONAUDIO |
IEC958_AES0_CON_NOT_COPYRIGHT;
	iec958.status[1] = IEC958_AES1_CON_PCM_CODER |
IEC958_AES1_CON_ORIGINAL;
	iec958.status[2] = 0x00;
	iec958.status[3] = IEC958_AES3_CON_FS_48000;

	llprintf(LOG_MIXER,"Writing
AES0=0x%02x,AES1=0x%02x,AES2=0x%02x,AES3=0x%02x\n",
		   iec958.status[0], iec958.status[1], iec958.status[2],
iec958.status[3]);

	/* store the values */
	snd_ctl_elem_value_set_iec958(cval, &iec958);
	if ((err = snd_ctl_elem_write(ctl_handle, cval)) < 0) {
		xprintf (this->class->xine, XINE_VERBOSITY_DEBUG,
"snd_ctl_elem_write(): %s\n", snd_strerror(err));
	}

	...
/*----------------------------------------------------------------------
-----*/
snd_sctl_install resets the IEC958 status bits back to the original
values!

I am pulling my hair out trying to understand how to stop this.

Unfortunately I don't have much time to fix this, please help.


----------------------------------------------------
Bob Bouterse
Sr. Software Engineer
Office of the CTO
D&M Holdings Inc.
1-317-616-6541
(fax) 1-317-616-6541
