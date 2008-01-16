From: Jean Batrel <jean.batrel@voila.fr>
Subject: Re: hdsp driver broken for Multiface II Rev 35
Date: Wed, 16 Jan 2008 23:43:44 +0100 (CET)
Message-ID: <14066785.203301200523424187.JavaMail.www@wwinf4612>
Reply-To: jean.batrel@voila.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.voila.fr (smtp1.voila.fr [193.252.22.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 0620B24567
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:43:45 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf4006.voila.fr (SMTP Server) with ESMTP id 3473A1C013DB
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:43:44 +0100 (CET)
Received: from wwinf4612 (wwinf4612 [10.232.13.55])
	by mwinf4006.voila.fr (SMTP Server) with ESMTP id 2F3AA1C013A1
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:43:44 +0100 (CET)
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

> Date: Mon, 14 Jan 2008 02:21:42 +0100
> From: Andreas Degert <ad@papyrus-gmbh.de>
> Subject: [alsa-devel] hdsp driver broken for Multiface II Rev 35
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de
> Message-ID: <20080114022142.51d6ae44@pluto.noname>
> Content-Type: text/plain; charset=US-ASCII
> 
> Hi folks,
> 
> changeset 5326 from 2007/08/31 broke the driver for this card revision.
> There was an older thread about this problem which didn't seem to come
> to a conclusion.
> (...) 
> Similar changes must be made to hdsp_input_to_output_key. Does anyone
> know which firmware revision exist for which card (io_type) ?
> 
> thank you
> Andreas Degert
> ------------------------------
Bonjour !

You are asking for firmware revision and (RME) cards :
I use a HDSP9632 RME card with issues : my card is Rev. 1.53 and only the 1.51 version is working with Linux, AFAIK...
The card is detected, there is some activity in the middle of HDSPmixer, but I can hear no sound...
A lspci says :
02:01.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP (rev 99)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 255
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at feaf0000 (32-bit, non-prefetchable) [size=64K]
I have no very skills with Linux yet, but I very hope getting this card working with Linux.
Can you help me please ? I very apologize if this mail is not relevant in this list.
But I very thank you in advance (I use Fedora 8 and the latest CCRMA kernel) !

Jean Batrel - jean.batrel@voila.fr
