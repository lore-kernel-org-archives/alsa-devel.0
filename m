From: Case van Rij <case@seattle.gii.net>
Subject: 24 bit pcm_meter ?
Date: Wed, 16 Jul 2003 07:56:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030716145649.GA9101@seattle.gii.net>
References: <20030715185511.19935.h007.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030715185511.19935.h007.c012.wm@mail.icqmail.com.criticalpath.net>
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


I'm trying to write and/or use a meter plugin like ameter with the rme
hammerfall dsp/rme 9652 so much without much success, presumably because
of the 24 bit/non-interleaved format this card seems to internally (?) 

I noticed s16_enable( ) in alsa-lib/pcm_meter.c includes some support
for other slave pcm formats, would that (in theory) mean it should work
with the RME ? 

snd_pcm_scope_s16_open( ) does seem to work (it doesnt fail) but 
when running arecord 
pcm_mmap.c:137: snd_pcm_mmap_read_areas: 
Assertion `snd_pcm_mmap_capture_avail(pcm) >= size)`

snd_pcm_mmap_capture_avail returns 0 which shouldnt happen in
snd_pcm_mmap_read_areas() .. im trying to determine if this would be the
result of the format issue. 

So far attempts at using a plug with a fixed format as slave for ameter
have failed. 

pcm.short { 
    type plug; 
    slave { 
        pcm "hw:0,0" 
		format "S16_LE"
    }
}

pcm.ameter {
    type meter
#   slave.pcm 'hw:0,0'
    slave.pcm 'short'
    frequency 10
    scopes.0 ameter
}

Any ideas ? 

Thanks,
Case


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
