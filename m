From: Pannaga Bhushan <bhushan@multitech.co.in>
Subject: pcm_lib.c . how does delta show wrong int. ack?
Date: Mon, 21 Oct 2002 09:21:16 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB379B4.762BC79E@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


Hi all,
         In the file pcm_lib.c and in the funtion -
snd_pcm_hw_ptr_interrupt() ,  there are the following lines --

-----------------

delta = hw_ptr_interrupt - new_hw_ptr;
if(delta > 0) {
    if( delta < runtime->buffer_size / 2) {
        snd_printd("Unexpected hw_pointer value .... wrong interrupt
acknowledge?\n"...);
        return 0;
    }
    runtime->hw_ptr_base += runtime->buffer_size;
    -------
    ------
    -------
}

-----------------

Can you pls clarify what these lines are doing? what is the significance
of delta and the significance of delta > 0 but less than
runtime->buffer_size/2   being a case of wrong interrupt ack.

thanx in advance,
Pannaga Bhushan


-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
