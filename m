From: Eugeni Doljenko <dolzenko@rsu.ru>
Subject: Sample loss in full duplex program
Date: Mon, 20 Oct 2003 19:04:20 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F93F974.5030506@rsu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have add code below to example program latency.c:
It just wrote first 100000 samples to the file "rawout" in plain text 
format.
I have simple program which helps me to analyse such files.
With that program I've found that some samples are lost (~ one per 4000)
(My settings:       latency_min = 8192;      /* in frames / 2 */
   latency_max = 8192;      /* in frames / 2 */
   block = 1;              /* block mode */   // When set to 0 I got 
awfull sample lost
   tick_time = 1;          /* disabled, otherwise in us */
   tick_time_ok = 0;
   use_poll = 1;
)

What can I do to not loss that samples in full duplex mode?

Sorry for my English.
Eugeni.


latency.c:
/*around string N649*/
       ok = 1;         // was here
       in_max = 0;  // was here
//prepare big buffer
   double* filebuf = malloc(500000*sizeof(double));  //I've added
   int    filebufp = 0; //I've added
   FILE* file;           //I've added
   short* shortbuf;   //I've added
   int i;                     //I've added
             while (ok && frames_in < loop_limit) {       // was here
           if (use_poll) {                                            // 
was here
               /* use poll to wait for next event */       // was here
               snd_pcm_wait(chandle, 1000);             // was here
           }       // was here
           if ((r = readbuf(chandle, buffer, latency, &frames_in, 
&in_max)) < 0)       // was here
               ok = 0;                                                
    // was here
           else {                                                 
         // was here
               if (effect)   //I've added // was here
                   applyeffect(buffer,r);                            // 
was here

       shortbuf = (short*)buffer;                                 //I've 
added
              //write to big buffer
       for(i=0; i<r; i++)                                              
//I've added
       {                                                                
     //I've added
           filebuf[filebufp] = shortbuf[i];                       //I've 
added
           filebufp++;                                                  
//I've added
       }                                                          
           //I've added
//write big buffer to file
       if(filebufp>100000)                                        //I've 
added
       {                                                            
           //I've added
           file = fopen("rawout", "w");                        //I've added
           for(i=0; i<100000; i++)                                 
//I've added
           fprintf(file, "%f\n", filebuf[i]/32000);           //I've added
           fclose(file);                                               
    //I've added
            exit(1);                                                   
     //I've added
       } 



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
