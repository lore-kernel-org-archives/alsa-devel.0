Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C8AC432C3
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 21:25:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483012068F
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W4Mf4YpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483012068F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8074E17A2;
	Thu, 21 Nov 2019 22:24:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8074E17A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574371546;
	bh=R3gcYYOC2mej595fKd+fSMIbO0O9d3DQ1bBb38iGcz0=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W4Mf4YpJ2Ys8vCFTwggaB1nP78vor2gvL3wpij7DtXYBCzJl6CXqB6gCqFLts8QAO
	 NDWHleSqbCgZqKzU6aCdoUUjQ12VrsXqBdWVDmSC1DpB2r6BE41ATNelZpQYChY0Rd
	 TYEth2inS1cIy1q7+0CepsyAmTAORuNUf3ISkdsM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00E76F80145;
	Thu, 21 Nov 2019 22:24:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1295BF80146; Thu, 21 Nov 2019 22:24:55 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8A91BF800C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 22:24:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A91BF800C1
MIME-Version: 1.0
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1574371491782548904-webhooks-bot@alsa-project.org>
References: <1574371491782548904-webhooks-bot@alsa-project.org>
Message-Id: <20191121212455.1295BF80146@alsa1.perex.cz>
Date: Thu, 21 Nov 2019 22:24:55 +0100 (CET)
Subject: [alsa-devel] alsa-lib Plugin: File deadlock when piping to shell
	command
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #14 was opened from bharris6:

When using the [ALSA File plugin](https://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html) you can tell it to pipe playback data to either a file or a program/shell command.

>Output filename (or shell command the stream will be piped to if STR starts with the pipe char).  

Piping to a shell command (as shown below) causes a deadlock where alsa waits for the shell command to return at the same time that the shell command is waiting for alsa to write to its STDIN.

>From the [source code](https://github.com/alsa-project/alsa-lib/blob/master/src/pcm/pcm_file.c), it appears that [popen](https://pubs.opengroup.org/onlinepubs/009695399/functions/popen.html) is being used to initialize/open the output file specified in configuration:  

    static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
    {
        int err, fd;
    
        /* fname can contain keys, generating final_fname */
        err = snd_pcm_file_replace_fname(file, &(file->final_fname));
        if (err < 0)
            return err;
        /*printf("DEBUG - original fname: %s, final fname: %s\n",
          file->fname, file->final_fname);*/
    
        if (file->final_fname[0] == '|') {
            /* pipe mode */
            FILE *pipe;
            /* clearing */
            pipe = popen(file->final_fname + 1, "w");
            if (!pipe) {
                SYSERR("running %s for writing failed",
                        file->final_fname);
                return -errno;
            }
            fd = dup(fileno(pipe));
            err = -errno;
            pclose(pipe);
            if (fd < 0) {
                SYSERR("unable to dup pipe file handle for command %s",
                        file->final_fname);
                return err;  

Although I can confirm the file I pass in my ALSA configuration gets started fine, it never receives anything on its `stdin` like ALSA's (and popen's) documentation states it should:  

>If mode is w, *when the child process is started its file descriptor STDIN_FILENO shall be the readable end of the pipe*, and the file descriptor fileno(stream) in the calling process, where stream is the stream pointer returned by popen(), shall be the writable end of the pipe.

My /etc/asound.conf: 

    pcm.!default {
        type plug
        slave.pcm "duplicator
    }
    
    pcm.default {
        type plug
        slave.pcm "duplicator"
    }
    
    pcm.dmixer {
        type dmix
        ipc_key 1024
        ipc_key_add_uid false
        ipc_perm 0666
        slave {
            pcm "hw:0,0"
            period_time 0
            period_size 1024
            buffer_size 8192
            rate 44100
        }
    }    
    
    pcm.duplicator {
        type plug
        slave.pcm {
            type multi
            slave {
                a { pcm "dmixer" channels 2 }
                b { pcm "fileout" channels 2 }
            }
            bindings [
                { slave a channel 0 }
                { slave a channel 1 }
                { slave b channel 0 }
                { slave b channel 1 }
            ]
        }
        ttable [
            [ 1 0 1 0 ]
            [ 0 1 0 1 ]
        ]
    }

    pcm.fileout {
        type file
        slave.pcm "null"
        file "|safe_fifo_alt"
        format raw
        perm 0666
    }  

safe_fifo_alt:  

    #!/usr/bin/python3
    import os, sys
    
    BUFFER_SIZE = 16384
    
    path = "/tmp/audio"
    if not os.path.exists(path):
        os.mkfifo(path)
        
    _fifo_in = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
    _fifo_out = os.open(path, os.WR_ONLY | os.O_NONBLOCK)
    
    for chunk in iter(lambda: sys.stdin.buffer.read(BUFFER_SIZE), b''):
        os.write(_fifo_out, chunk)
        
    os.close(_fifo_in)
    os.close(_fifo_out)  

I based `safe_fifo_alt` on [safe_fifo](https://github.com/dpayne/cli-visualizer/blob/master/bin/safe_fifo.c) from `cli-visualizer`.  They both hang indefinitely on their STDIN read because alsa is hanging on its `pclose()`.  

I've tested an alternative method to simulate the popen and pipe into their STDIN to make sure it worked, specifically:  

    head -c 500 /dev/urandom | sh -c safe_fifo_alt  

It appears this was changed in revision 022c790aabc300eabad4da8947a3f2bdadce41e1, where the `dup()` and `pclose()` calls were added and introduced the deadlock.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/14
Repository URL: https://github.com/alsa-project/alsa-lib
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
