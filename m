From: Michele Curti <michele.curti@gmail.com>
Subject: sound on asus x205ta
Date: Thu, 28 Apr 2016 23:56:40 +0200
Message-ID: <20160428215640.GA930@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id BF7BE2650C0
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 23:56:44 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id e201so1031375wme.2
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 14:56:44 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pierre-louis.bossart@linux.intel.com, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Thu, Mar 03, 2016 at 10:20:55AM -0600, Pierre-Louis Bossart wrote:
> On 3/3/16 5:27 AM, Vinod Koul wrote:
> >On Thu, Mar 03, 2016 at 12:11:10PM +0100, Michele Curti wrote:
> >>Hi Vinod,
> >>
> >>>>[    7.970937] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
> >>>>[    7.970964] intel_sst_acpi 80860F28:00: fw returned err -16
> >>>Yes this is a problem, which FW are you using
> >
> >Have you tried the recent kernels, Pierre did a bunch of update and got many
> >things working.
> >
> >As for timeout, that simply means we have send a message to DSP which failed
> >to get a response. Perhpas the message had some bad element of FW had a
> >bug/crashed...
> 
> The firmware timeout is due to a change in the BIOS for BYT-CR devices that
> impacts the IPC interrupt number, I have a set of patches that fix this on
> Asus T100TAF but I still can't get any sound out.
>

Hi!

So, it seems I got dsp interrupts after the timeout errors. I added
	dev_dbg(drv->dev, "Interrupt received\n");
to the intel_sst_interrupt_mrfld() function

[zio@asus ~]$ dmesg | grep "Interrupt received" | wc -l
105
[zio@asus ~]$ cat /proc/interrupts | grep sst
   1:        105          0          0          0   IO-APIC   29-fasteoi   intel_sst_driver
[zio@asus ~]$ dmesg | grep intel_sst
[    3.003961] intel_sst_acpi 80860F28:00: LPE base: 0x90a00000 size:0x200000
[    3.003970] intel_sst_acpi 80860F28:00: IRAM base: 0x90ac0000
[    3.004002] intel_sst_acpi 80860F28:00: DRAM base: 0x90b00000
[    3.004013] intel_sst_acpi 80860F28:00: SHIM base: 0x90b40000
[    3.004024] intel_sst_acpi 80860F28:00: Mailbox base: 0x90b44000
[    3.004033] intel_sst_acpi 80860F28:00: DDR base: 0x20000000
[    3.004260] intel_sst_acpi 80860F28:00: Got drv data max stream 25
[    3.004388] intel_sst_acpi 80860F28:00: Registered IRQ 0x1
[    3.004396] intel_sst_acpi 80860F28:00: Requesting FW intel/fw_sst_0f28_ssp0.bin now...
[    3.004792] intel_sst_acpi 80860F28:00: LPE is already in RESET state, No action
[    3.024222] intel_sst_acpi 80860F28:00: Enter
[    3.024232] intel_sst_acpi 80860F28:00: Request Fw completed
[    3.024507] intel_sst_acpi 80860F28:00: copied fw to ffff88007a900000
[    3.024514] intel_sst_acpi 80860F28:00: phys: 7a900000
[    3.024933] intel_sst_acpi 80860F28:00: Enter
[    3.024943] intel_sst_acpi 80860F28:00: header sign=$SST\xffffff96\xffffffb4
[    3.024949] intel_sst_acpi 80860F28:00: module sign $SST\xffffff82\xffffffb4
[    3.024955] intel_sst_acpi 80860F28:00: module entrypoint 0x0
[    4.905820] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[    4.905833] intel_sst_acpi 80860F28:00: fw returned err -16
[    5.905864] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[    5.905891] intel_sst_acpi 80860F28:00: fw returned err -16
[    6.905818] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[    6.905838] intel_sst_acpi 80860F28:00: fw returned err -16
[    7.905823] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[    7.905849] intel_sst_acpi 80860F28:00: fw returned err -16
[    8.905820] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[    8.905847] intel_sst_acpi 80860F28:00: fw returned err -16
[    9.905830] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[    9.905857] intel_sst_acpi 80860F28:00: fw returned err -16
[   10.905828] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   10.905855] intel_sst_acpi 80860F28:00: fw returned err -16
[   11.905826] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   11.905853] intel_sst_acpi 80860F28:00: fw returned err -16
[   12.905828] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   12.905854] intel_sst_acpi 80860F28:00: fw returned err -16
[   13.905819] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   13.905843] intel_sst_acpi 80860F28:00: fw returned err -16
[   14.925811] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   14.925836] intel_sst_acpi 80860F28:00: fw returned err -16
[   15.925823] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   15.925850] intel_sst_acpi 80860F28:00: fw returned err -16
[   16.925819] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   16.925844] intel_sst_acpi 80860F28:00: fw returned err -16
[   17.925818] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   17.925841] intel_sst_acpi 80860F28:00: fw returned err -16
[   18.925821] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   18.925845] intel_sst_acpi 80860F28:00: fw returned err -16
[   19.925810] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   19.925834] intel_sst_acpi 80860F28:00: fw returned err -16
[   20.925788] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   20.925809] intel_sst_acpi 80860F28:00: fw returned err -16
[   21.925821] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   21.925846] intel_sst_acpi 80860F28:00: fw returned err -16
[   22.920830] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   22.920856] intel_sst_acpi 80860F28:00: fw returned err -16
[   23.884836] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   23.884859] intel_sst_acpi 80860F28:00: fw returned err -16
[   24.853161] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   24.853174] intel_sst_acpi 80860F28:00: fw returned err -16
[   25.825400] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   25.825427] intel_sst_acpi 80860F28:00: fw returned err -16
[   26.800986] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   26.801008] intel_sst_acpi 80860F28:00: fw returned err -16
[   27.779566] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   27.779592] intel_sst_acpi 80860F28:00: fw returned err -16
[   28.760784] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   28.760809] intel_sst_acpi 80860F28:00: fw returned err -16
[   29.744302] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   29.744328] intel_sst_acpi 80860F28:00: fw returned err -16
[   30.729854] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   30.729881] intel_sst_acpi 80860F28:00: fw returned err -16
[   31.717175] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   31.717202] intel_sst_acpi 80860F28:00: fw returned err -16
[   32.706075] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   32.706102] intel_sst_acpi 80860F28:00: fw returned err -16
[   33.696343] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   33.696367] intel_sst_acpi 80860F28:00: fw returned err -16
[   34.687818] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   34.687844] intel_sst_acpi 80860F28:00: fw returned err -16
[   35.680357] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   35.680383] intel_sst_acpi 80860F28:00: fw returned err -16
[   36.673818] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   36.673844] intel_sst_acpi 80860F28:00: fw returned err -16
[   37.668111] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   37.668135] intel_sst_acpi 80860F28:00: fw returned err -16
[   38.663091] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   38.663118] intel_sst_acpi 80860F28:00: fw returned err -16
[   39.658680] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   39.658691] intel_sst_acpi 80860F28:00: fw returned err -16
[   40.654812] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   40.654824] intel_sst_acpi 80860F28:00: fw returned err -16
[   41.651466] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   41.651479] intel_sst_acpi 80860F28:00: fw returned err -16
[   42.648513] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x1 fw_state 0x3
[   42.648525] intel_sst_acpi 80860F28:00: fw returned err -16
[   43.645942] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   43.645952] intel_sst_acpi 80860F28:00: fw returned err -16
[   45.052845] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   45.052873] intel_sst_acpi 80860F28:00: fw returned err -16
[   46.050948] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   46.050960] intel_sst_acpi 80860F28:00: fw returned err -16
[   47.049320] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   47.049331] intel_sst_acpi 80860F28:00: fw returned err -16
[   48.047885] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   48.047896] intel_sst_acpi 80860F28:00: fw returned err -16
[   49.046627] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   49.046638] intel_sst_acpi 80860F28:00: fw returned err -16
[   50.045542] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   50.045553] intel_sst_acpi 80860F28:00: fw returned err -16
[   51.044603] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   51.044632] intel_sst_acpi 80860F28:00: fw returned err -16
[   52.043787] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   52.043815] intel_sst_acpi 80860F28:00: fw returned err -16
[   53.043030] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   53.043056] intel_sst_acpi 80860F28:00: fw returned err -16
[   54.042669] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   54.042696] intel_sst_acpi 80860F28:00: fw returned err -16
[   55.045310] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   55.045337] intel_sst_acpi 80860F28:00: fw returned err -16
[   56.047789] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   56.047815] intel_sst_acpi 80860F28:00: fw returned err -16
[   57.050159] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   57.050185] intel_sst_acpi 80860F28:00: fw returned err -16
[   58.052350] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   58.052362] intel_sst_acpi 80860F28:00: fw returned err -16
[   59.054494] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   59.054521] intel_sst_acpi 80860F28:00: fw returned err -16
[   60.056485] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   60.056511] intel_sst_acpi 80860F28:00: fw returned err -16
[   61.058360] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   61.058385] intel_sst_acpi 80860F28:00: fw returned err -16
[   62.060160] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   62.060189] intel_sst_acpi 80860F28:00: fw returned err -16
[   63.061829] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   63.061840] intel_sst_acpi 80860F28:00: fw returned err -16
[   64.063443] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   64.063469] intel_sst_acpi 80860F28:00: fw returned err -16
[   65.064970] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   65.064997] intel_sst_acpi 80860F28:00: fw returned err -16
[   66.066390] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   66.066403] intel_sst_acpi 80860F28:00: fw returned err -16
[   67.067803] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   67.067829] intel_sst_acpi 80860F28:00: fw returned err -16
[   68.069108] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   68.069134] intel_sst_acpi 80860F28:00: fw returned err -16
[   69.070353] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   69.070380] intel_sst_acpi 80860F28:00: fw returned err -16
[   70.071530] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   70.071553] intel_sst_acpi 80860F28:00: fw returned err -16
[   71.072665] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   71.072692] intel_sst_acpi 80860F28:00: fw returned err -16
[   72.077040] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   72.077050] intel_sst_acpi 80860F28:00: fw returned err -16
[   73.078102] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   73.078128] intel_sst_acpi 80860F28:00: fw returned err -16
[   74.079073] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   74.079099] intel_sst_acpi 80860F28:00: fw returned err -16
[   75.080034] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   75.080060] intel_sst_acpi 80860F28:00: fw returned err -16
[   76.080922] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   76.080949] intel_sst_acpi 80860F28:00: fw returned err -16
[   77.081768] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   77.081794] intel_sst_acpi 80860F28:00: fw returned err -16
[   78.082592] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   78.082617] intel_sst_acpi 80860F28:00: fw returned err -16
[   79.083395] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   79.083422] intel_sst_acpi 80860F28:00: fw returned err -16
[   80.084155] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   80.084181] intel_sst_acpi 80860F28:00: fw returned err -16
[   81.084883] intel_sst_acpi 80860F28:00: Wait timed-out condition:0x0, msg_id:0x2 fw_state 0x3
[   81.084910] intel_sst_acpi 80860F28:00: fw returned err -16
[   81.187135] intel_sst_acpi 80860F28:00: sst_load_fw
[   81.187162] intel_sst_acpi 80860F28:00: sst: Resetting the DSP in mrfld
[   81.187174] intel_sst_acpi 80860F28:00: value:0x1e40001
[   81.187184] intel_sst_acpi 80860F28:00: value:0x1e40007
[   81.187193] intel_sst_acpi 80860F28:00: value:0x1e40006
[   81.229015] intel_sst_acpi 80860F28:00: config written to DCCM
[   81.229024] intel_sst_acpi 80860F28:00: sst: Starting the DSP in mrfld LALALALA
[   81.229030] intel_sst_acpi 80860F28:00: value:0x1e40006
[   81.229035] intel_sst_acpi 80860F28:00: value:0x1e40007
[   81.229041] intel_sst_acpi 80860F28:00: sst: Starting the DSP_merrifield:1e40802
[   81.239680] intel_sst_acpi 80860F28:00: Interrupt received
[   81.239999] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240040] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240113] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240165] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240232] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240252] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240322] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240357] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240423] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240451] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240517] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240538] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240601] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240632] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240695] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240719] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240785] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240817] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240883] intel_sst_acpi 80860F28:00: Interrupt received
[   81.240956] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241029] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241099] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241176] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241218] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241298] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241340] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241413] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241451] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241475] intel_sst_acpi 80860F28:00: FW sent error response 0x5000e
[   81.241528] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241552] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241580] intel_sst_acpi 80860F28:00: FW sent error response 0x5000e
[   81.241638] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241661] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241692] intel_sst_acpi 80860F28:00: FW sent error response 0x5000e
[   81.241734] intel_sst_acpi 80860F28:00: Interrupt received
[   81.241999] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242069] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242096] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242145] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242298] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242340] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242400] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242431] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242550] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242570] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242689] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242807] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242828] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242888] intel_sst_acpi 80860F28:00: Interrupt received
[   81.242919] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243012] intel_sst_acpi 80860F28:00: FW sent async error msg:
[   81.243029] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243048] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243163] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243277] intel_sst_acpi 80860F28:00: fw load successful!!!
[   81.243279] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243307] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243384] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243460] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243503] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243541] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243614] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243653] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243684] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243715] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243757] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243789] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243820] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243860] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243911] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243953] intel_sst_acpi 80860F28:00: Interrupt received
[   81.243994] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244036] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244078] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244120] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244170] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244213] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244257] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244298] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244340] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244382] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244423] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244472] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244517] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244639] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244769] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244792] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244915] intel_sst_acpi 80860F28:00: Interrupt received
[   81.244956] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245058] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245187] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245316] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245424] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245479] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245532] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245579] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245623] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245672] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245706] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245748] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245786] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245816] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245880] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245931] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245967] intel_sst_acpi 80860F28:00: Interrupt received
[   81.245997] intel_sst_acpi 80860F28:00: Interrupt received
[   81.246050] intel_sst_acpi 80860F28:00: Interrupt received
[   84.180360] intel_sst_acpi 80860F28:00: Interrupt received
[   84.180479] intel_sst_acpi 80860F28:00: sst: Resetting the DSP in mrfld
[   84.180507] intel_sst_acpi 80860F28:00: value:0x1e4080a
[   84.180524] intel_sst_acpi 80860F28:00: value:0x1e40807
[   84.180539] intel_sst_acpi 80860F28:00: value:0x1e40806



Am I doing something wrong? Any hints?

Thanks,
Michele





My changes:

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/codecs/rt5645.c             |   2 +
 sound/soc/intel/Kconfig               |  13 ++
 sound/soc/intel/atom/sst/sst.c        |   3 +
 sound/soc/intel/atom/sst/sst_acpi.c   |   4 +-
 sound/soc/intel/atom/sst/sst_loader.c |   1 +
 sound/soc/intel/boards/Makefile       |   2 +
 sound/soc/intel/boards/bytcr_rt5645.c | 332 ++++++++++++++++++++++++++++++++++
 7 files changed, 356 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/boards/bytcr_rt5645.c

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7af5e73..c48e5c8 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3524,6 +3524,7 @@ static const struct regmap_config temp_regmap = {
 
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
+	{ "rt5648", 0 },
 	{ "rt5650", 0 },
 	{ }
 };
@@ -3532,6 +3533,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
+	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{},
 };
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index b3e6c23..46b7f8b 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -108,6 +108,19 @@ config SND_SOC_INTEL_BYTCR_RT5640_MACH
           Say Y if you have such a device
           If unsure select "N".
 
+config SND_SOC_INTEL_BYTCR_RT5645_MACH
+        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5645 codec"
+	depends on X86 && I2C
+	select SND_SOC_RT5645
+	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
+	help
+          This adds support for ASoC machine driver for Intel(R) Baytrail and Baytrail-CR
+          platforms with RT5645 audio codec.
+          Say Y if you have such a device
+          If unsure select "N".
+
 config SND_SOC_INTEL_BYTCR_RT5651_MACH
         tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with RT5651 codec"
 	depends on X86 && I2C
diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a4b458e..3ffdb2e 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -19,6 +19,7 @@
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
+#define DEBUG	1
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -58,6 +59,8 @@ static irqreturn_t intel_sst_interrupt_mrfld(int irq, void *context)
 	unsigned int size = 0;
 	struct intel_sst_drv *drv = (struct intel_sst_drv *) context;
 	irqreturn_t retval = IRQ_HANDLED;
+	
+	dev_dbg(drv->dev, "Interrupt received\n");
 
 	/* Interrupt arrived, check src */
 	isr.full = sst_shim_read64(drv->shim, SST_ISRX);
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3bc4b63..38447d2 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -109,7 +109,7 @@ static const struct sst_res_info byt_rvp_res_info = {
 	.mbox_size = 0x1000,
 	.acpi_lpe_res_index = 0,
 	.acpi_ddr_index = 2,
-	.acpi_ipc_irq_index = 5,
+	.acpi_ipc_irq_index = 0,
 };
 
 static struct sst_platform_info byt_rvp_platform_data = {
@@ -327,6 +327,8 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"INTCCFFD", "bytcr_rt5640", "intel/fw_sst_0f28.bin", "bytcr_rt5640", NULL,
 						&byt_rvp_platform_data },
+	{"10EC5648", "bytcr_rt5645", "intel/fw_sst_0f28_ssp0.bin", "bytcr_rt5645", NULL,
+						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
 						&byt_rvp_platform_data },
 	{},
diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 3391714..9b750ed 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -22,6 +22,7 @@
  *  This file contains all dsp controlling functions like firmware download,
  * setting/resetting dsp cores, etc
  */
+#define DEBUG 1
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 3310c0f..af24d39 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -3,6 +3,7 @@ snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
+snd-soc-sst-bytcr-rt5645-objs := bytcr_rt5645.o
 snd-soc-sst-bytcr-rt5651-objs := bytcr_rt5651.o
 snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
@@ -16,6 +17,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
+obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5645_MACH) += snd-soc-sst-bytcr-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH) += snd-soc-sst-bytcr-rt5651.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
diff --git a/sound/soc/intel/boards/bytcr_rt5645.c b/sound/soc/intel/boards/bytcr_rt5645.c
new file mode 100644
index 0000000..4974d6b
--- /dev/null
+++ b/sound/soc/intel/boards/bytcr_rt5645.c
@@ -0,0 +1,332 @@
+/*
+ *  bytcr_rt5645.c - ASoc Machine driver for Intel Byt CR platform
+ *  (derived from bytcr_rt5640.c)
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../../codecs/rt5645.h"
+#include "../atom/sst-atom-controls.h"
+
+static const struct snd_soc_dapm_widget byt_rt5645_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_audio_map[] = {
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+
+	{"Headset Mic", NULL, "micbias1"}, /* lowercase for rt5645 */
+	{"IN2P", NULL, "Headset Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Speaker", NULL, "LOUTL"},
+	{"Speaker", NULL, "LOUTR"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_intmic_dmic1_map[] = {
+	{"DMIC1", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_intmic_dmic2_map[] = {
+	{"DMIC2", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_intmic_in1_map[] = {
+	{"Internal Mic", NULL, "micbias1"},
+	{"IN1P", NULL, "Internal Mic"},
+};
+
+enum {
+	BYT_RT5645_DMIC1_MAP,
+	BYT_RT5645_DMIC2_MAP,
+	BYT_RT5645_IN1_MAP,
+};
+
+#define BYT_RT5645_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5645_DMIC_EN	BIT(16)
+
+static unsigned long byt_rt5645_quirk = BYT_RT5645_DMIC1_MAP |
+					BYT_RT5645_DMIC_EN;
+
+static const struct snd_kcontrol_new byt_rt5645_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int byt_rt5645_aif1_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	snd_soc_dai_set_bclk_ratio(codec_dai, 50);
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_PLL1,
+				     params_rate(params) * 512,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5645_PLL1_S_BCLK1,
+				  params_rate(params) * 50,
+				  params_rate(params) * 512);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dmi_system_id byt_rt5645_quirk_table[] = {
+	{}
+};
+
+static int byt_rt5645_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+	const struct snd_soc_dapm_route *custom_map;
+	int num_routes;
+
+	card->dapm.idle_bias_off = true;
+
+	dmi_check_system(byt_rt5645_quirk_table);
+	switch (BYT_RT5645_MAP(byt_rt5645_quirk)) {
+	case BYT_RT5645_IN1_MAP:
+		custom_map = byt_rt5645_intmic_in1_map;
+		num_routes = ARRAY_SIZE(byt_rt5645_intmic_in1_map);
+		break;
+	case BYT_RT5645_DMIC2_MAP:
+		custom_map = byt_rt5645_intmic_dmic2_map;
+		num_routes = ARRAY_SIZE(byt_rt5645_intmic_dmic2_map);
+		break;
+	default:
+		custom_map = byt_rt5645_intmic_dmic1_map;
+		num_routes = ARRAY_SIZE(byt_rt5645_intmic_dmic1_map);
+	}
+
+	ret = snd_soc_add_card_controls(card, byt_rt5645_controls,
+					ARRAY_SIZE(byt_rt5645_controls));
+	if (ret) {
+		dev_err(card->dev, "unable to add card controls\n");
+		return ret;
+	}
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
+
+	return ret;
+}
+
+static const struct snd_soc_pcm_stream byt_rt5645_dai_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
+static int byt_rt5645_codec_fixup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	int ret;
+
+	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP2 to 24-bit */
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+
+	/*
+	 * Default mode for SSP configuration is TDM 4 slot, override config
+	 * with explicit setting to I2S 2ch 24-bit. The word length is set with
+	 * dai_set_tdm_slot() since there is no other API exposed
+	 */
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+				  SND_SOC_DAIFMT_I2S     |
+				  SND_SOC_DAIFMT_NB_IF   |
+				  SND_SOC_DAIFMT_CBS_CFS
+				  );
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned int rates_48000[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count = ARRAY_SIZE(rates_48000),
+	.list  = rates_48000,
+};
+
+static int byt_rt5645_aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops byt_rt5645_aif1_ops = {
+	.startup = byt_rt5645_aif1_startup,
+};
+
+static struct snd_soc_ops byt_rt5645_be_ssp2_ops = {
+	.hw_params = byt_rt5645_aif1_hw_params,
+};
+
+static struct snd_soc_dai_link byt_rt5645_dais[] = {
+	[MERR_DPCM_AUDIO] = {
+		.name = "Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "media-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_rt5645_aif1_ops,
+	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &byt_rt5645_aif1_ops,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Compressed Port",
+		.stream_name = "Compress",
+		.cpu_dai_name = "compress-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+	},
+	/* CODEC<->CODEC link */
+	/* back ends */
+	{
+		.name = "SSP2-Codec",
+		.be_id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC5648:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+						| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = byt_rt5645_codec_fixup,
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = byt_rt5645_init,
+		.ops = &byt_rt5645_be_ssp2_ops,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card byt_rt5645_card = {
+	.name = "bytcr-rt5645",
+	.owner = THIS_MODULE,
+	.dai_link = byt_rt5645_dais,
+	.num_links = ARRAY_SIZE(byt_rt5645_dais),
+	.dapm_widgets = byt_rt5645_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5645_widgets),
+	.dapm_routes = byt_rt5645_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5645_audio_map),
+	.fully_routed = true,
+};
+
+static int snd_byt_rt5645_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+
+	/* register the soc card */
+	byt_rt5645_card.dev = &pdev->dev;
+
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_rt5645_card);
+
+	if (ret_val) {
+		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
+			ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &byt_rt5645_card);
+	return ret_val;
+}
+
+static struct platform_driver snd_byt_rt5645_mc_driver = {
+	.driver = {
+		.name = "bytcr_rt5645",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = snd_byt_rt5645_mc_probe,
+};
+
+module_platform_driver(snd_byt_rt5645_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Machine driver for RT5645");
+MODULE_AUTHOR("Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bytcr_rt5645");
-- 
2.8.0
