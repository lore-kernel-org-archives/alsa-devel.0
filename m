From: James Wright <james@jigsawdezign.com>
Subject: Moving from OSS to ALSA
Date: Sun, 11 Jan 2004 18:13:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040111181311.7726a5b5.james@jigsawdezign.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

   I am currently looking into rewriting our current OSS sound routines to native ALSA, as it seems OSS will invariably be phased out now that the ALSA driver is distrubuted with the Linux kernel, plus ALSA seems to have a great number of benefits for us. 

  Our current sound routines perform software sound sample mixing for use in games. All the  mixing and transfers happen in a non-blocking function called update_jsound() which we call every 1/60th of a second in our main game loop. We find the total size of the hardware ring buffer and use MMAP writes to it. We effectively break the ring buffer into 1024 byte "fragments", and always keep one whole fragment ahead to ensure no underruns. We do this by the follwing:



  ioctl(audiofd, SNDCTL_DSP_GETOPTR, &info);  // get position of DSP pointer

  if (info.ptr >= trigger){ // hit a frag boundary, so write another fragment ahead
      trigger += FRAGSIZE;  // move triggering position to next fragment boundary
      if (trigger >= DMA_SIZE) trigger = 0; // wrap around if at end of DMA buffer
      dptr = DMA_PTR + trigger;  // set write ptr to next fragment

      ...
      mix and write all samples playing into the buffer
      ...
 
      //printf("Ptr position: %u\n", info.ptr);
      //printf("Trigger: %u\n", trigger);
  }


   With all the different methods available the ALSA offers i'm finding it hard to determine the best method to use to do the same job as the OSS code. I have started by writing  a standard "write" access with non-blocking, with a buffersize of 500000 usecs and a period time of 100000 usecs, but i want to know how to determine if there is only one period remaning, which is when i would want to mix and write the next one ahead...

Sorry if this has been covered before...


Thanks,
James






-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
