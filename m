From: Brett Bolen <bbolen@extron.com>
Subject: Re: Audio Driver -- too much data,
	coming in two quickly
Date: Wed, 1 Sep 2010 15:11:31 +0000 (UTC)
Message-ID: <loom.20100901T170453-250@post.gmane.org>
References: <loom.20100901T153508-926@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7854B2415F
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 17:11:44 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OqoyT-0005RL-Bj
	for alsa-devel@alsa-project.org; Wed, 01 Sep 2010 17:11:41 +0200
Received: from rrcs-24-172-120-202.midsouth.biz.rr.com ([24.172.120.202])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 17:11:41 +0200
Received: from bbolen by rrcs-24-172-120-202.midsouth.biz.rr.com with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2010 17:11:41 +0200
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

Here's the source code for the example program I ran in the last message.

/*
 *  This example reads from the default PCM device
 */

/* Use the newer ALSA API */
#define ALSA_PCM_NEW_HW_PARAMS_API

#include <alsa/asoundlib.h>
#include <sys/time.h>


static snd_output_t *log;

double  arg_duration_ms = 2000.0;   // milliseconds
int     arg_sampling_rate = 48000;
char    arg_device_name[128]   = "plughw:0,0";
char    arg_output_fname[128]  = "/dev/null";
int     arg_frames = 16*1024;   // 16k

int verbose = 1;

/* @brief get number of seconds since timer reset
 * 
 */
unsigned long  base_tm;
unsigned long  get_time()
{
	// faster method?
	struct timeval   tv;
	unsigned long  tm;
	gettimeofday( &tv, NULL);
	tm = 1000l*1000l*tv.tv_sec; 
	tm +=  tv.tv_usec;
	return tm - base_tm;
}

void args( int argc, char *argv[])
{
    //int flags;
    int opt;
    
    // getopt
    while (( opt = getopt( argc, argv,"f:r:d:o:t:")) != -1) {
        switch (opt) {
            case 'f':
                arg_frames  = atoi(optarg);
                printf(" -- frames ( time samples) requested set to %d\n",
                       arg_frames);
                break;
            case 'r':
                arg_sampling_rate  = atoi(optarg);
                printf(" -- samping rate set to %d\n", arg_sampling_rate);
                break;
            case 'd':
                strcpy( arg_device_name, optarg);
                printf(" -- device_name set to '%s'\n", arg_device_name);
                break;
            case 't':
                printf("t optarg is %s\n", optarg);
                arg_duration_ms = (double) atoi(optarg);
                printf(" -- duration  set to %fms\n", arg_duration_ms);
                break;
            case 'o':
                strcpy( arg_output_fname, optarg);
                printf(" -- output file name  set to '%s'\n", arg_output_fname);
                break;
            default:
                fprintf(stderr, "Usage: %s \n"
                        " -r <rate>\n"
                        " -d <input_device_name>\n"
                        " -o <output_file_name>\n"
                        "",
                        argv[0]);
                exit( -1);
        }
    }
}


/***
 *
 *
 ***/
void dump_params( snd_pcm_t           *handle,
                  snd_pcm_hw_params_t *params )
{

    unsigned int val, val2;
    int dir;
    
    printf("PCM handle name = '%s'\n",
           snd_pcm_name(handle));
    
    printf("PCM state = %s\n",
           snd_pcm_state_name(snd_pcm_state(handle)));
    
    
    snd_pcm_hw_params_get_access(params,
                          (snd_pcm_access_t *) &val);

    printf("access type = %s\n",
           snd_pcm_access_name((snd_pcm_access_t)val));
    
    // changed val to fmt
    snd_pcm_format_t   fmt;
    snd_pcm_hw_params_get_format(params, &fmt);
    printf("format = '%s' (%s)\n",
           snd_pcm_format_name(fmt),
           snd_pcm_format_description(fmt));   
    
    snd_pcm_hw_params_get_subformat(params,
                                    (snd_pcm_subformat_t *)&val);
    printf("subformat = '%s' (%s)\n",
           snd_pcm_subformat_name((snd_pcm_subformat_t)val),
           snd_pcm_subformat_description(
               (snd_pcm_subformat_t)val));
    
    snd_pcm_hw_params_get_channels(params, &val);
    printf("channels = %d\n", val);
    
    snd_pcm_hw_params_get_rate(params, &val, &dir);
    printf("rate = %d bps\n", val);

    snd_pcm_hw_params_get_period_time(params, &val, &dir);
    printf("period time = %d us\n", val);

    snd_pcm_uframes_t  uframes;
    snd_pcm_hw_params_get_period_size(params, &uframes, &dir);
    printf("period size = %d frames !!\n", (int)uframes);

    snd_pcm_hw_params_get_buffer_time(params, &val, &dir);
    printf("buffer time = %d us\n", val);

    snd_pcm_hw_params_get_buffer_size(params, (snd_pcm_uframes_t *) &val);
    printf("buffer size = %d frames\n", val);

    snd_pcm_hw_params_get_periods(params, &val, &dir);
    printf("periods per buffer = %d frames\n", val);

    snd_pcm_hw_params_get_rate_numden(params,
                                      &val, &val2);
    printf("exact rate = %d/%d bps\n", val, val2);

    val = snd_pcm_hw_params_get_sbits(params);
    printf("significant bits = %d\n", val);

#if 0
    snd_pcm_hw_params_get_tick_time(params,  &val, &dir);
    printf("tick time = %d us\n", val);
#endif

    val = snd_pcm_hw_params_is_batch(params);
    printf("is batch = %d\n", val);

    val = snd_pcm_hw_params_is_block_transfer(params);
    printf("is block transfer = %d\n", val);

    val = snd_pcm_hw_params_is_double(params);
    printf("is double = %d\n", val);

    val = snd_pcm_hw_params_is_half_duplex(params);
    printf("is half duplex = %d\n", val);

    val = snd_pcm_hw_params_is_joint_duplex(params);
    printf("is joint duplex = %d\n", val);

    val = snd_pcm_hw_params_can_overrange(params);
    printf("can overrange = %d\n", val);

    val = snd_pcm_hw_params_can_mmap_sample_resolution(params);
    printf("can mmap = %d\n", val);

    val = snd_pcm_hw_params_can_pause(params);
    printf("can pause = %d\n", val);

    val = snd_pcm_hw_params_can_resume(params);
    printf("can resume = %d\n", val);

    val = snd_pcm_hw_params_can_sync_start(params);
    printf("can sync start = %d\n", val);
}

    


int main( int argc, char *argv[])
{
    long loops;
    int rc;
    int size;
    snd_pcm_t *handle;
    snd_pcm_hw_params_t *params;
    unsigned int val, val2;
    int dir;
    snd_pcm_uframes_t frames;
    char *buffer;

    fprintf(stderr, "alsa_capture: v0.1b\n");

    args(argc, argv);

    base_tm = get_time();

    unsigned long ttim[10];
    ttim[0] = get_time();    usleep (0);
    ttim[1] = get_time();    usleep (10);
    ttim[2] = get_time();    usleep (100);
    ttim[3] = get_time();    usleep (1000);
    ttim[4] = get_time();    usleep (10000);
    ttim[5] = get_time();    usleep (100000);
    ttim[6] = get_time();
    printf("delay calibration:"
           "0=%ld 10=%ld 100=%ld 1000=%ld 10000=%ld 100000=%ld ticks "
           "( %ld %ld %ld %ld %ld %ld %ld) ticks\n",
           
           ttim[1] - ttim[0],
           ttim[2] - ttim[1],
           ttim[3] - ttim[2],
           ttim[4] - ttim[3],
           ttim[5] - ttim[4],
           ttim[6] - ttim[5],
           
           ttim[6],  ttim[5],
           ttim[4],  ttim[3],
           ttim[2],  ttim[1],
           ttim[0]);

    /* Open PCM device for recording (capture). */
    rc = snd_pcm_open(&handle, arg_device_name,
                      SND_PCM_STREAM_CAPTURE, 0);
    if (rc < 0) {
        fprintf(stderr,
                "unable to open pcm device: %s\n",
                snd_strerror(rc));
        exit(1);
    }

    snd_output_stdio_attach(&log, stderr, 0);

    /* Allocate a hardware parameters object. */
    snd_pcm_hw_params_alloca(&params);

    /* Fill it in with default values. */
    snd_pcm_hw_params_any(handle, params);

    /* Set the desired hardware parameters. */

    /* Interleaved mode */
    snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);

    /* Signed 16-bit little-endian format */
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);

    /* Two channels (stereo) */
    snd_pcm_hw_params_set_channels(handle, params, 2);

    /* sampling rate in time_samples/second : cd=44100, dat=48000 */
    val = arg_sampling_rate;
    snd_pcm_hw_params_set_rate_near(handle, params, &val, &dir);

    /* Set period size to 32 frames. */
    frames = arg_frames;
    printf("Requesting %d frames per period\n", frames);
    snd_pcm_hw_params_set_period_size_near(handle, params, &frames, &dir);
    printf("Returned %d frames per period\n", frames);

    /* Write the parameters to the driver */
    rc = snd_pcm_hw_params(handle, params);
    if (rc < 0) {
        fprintf(stderr,
                "unable to set hw parameters: %s\n",
                snd_strerror(rc));
        exit(1);
    }


    printf("---------------------------after set hw params 1\n");
    dump_params( handle, params);
    printf(".........................................\n");


    int fout;
    fout = open(arg_output_fname, O_CREAT | O_WRONLY | O_TRUNC);
    if ( fout < 0) {
        printf("could not open output file\n");
        exit(-1);
    }
  
    /* Use a buffer large enough to hold one period */
    snd_pcm_hw_params_get_period_size(params,
                                      &frames, &dir);

    size = frames * 4; /* 2 bytes/sample, 2 channels */
    buffer = (char *) malloc(size);

    /* We want to loop for duration_ms */
    snd_pcm_hw_params_get_period_time(params, &val, &dir);
    
    loops = (int) (arg_duration_ms*1000 / val);
    printf("loops is %d/0x%x, period_time is %d/%x, frames=%d/%x\n",
           loops, loops,
           val, val,
           frames,frames);

    while (loops > 0) {
        snd_htimestamp_t   ts1;
        snd_pcm_uframes_t  frames1;


        snd_pcm_htimestamp( handle, &frames1, &ts1);
        loops--;
        
        ttim[0] = get_time();
        rc = snd_pcm_readi(handle, buffer, frames);
        ttim[1] = get_time();
        if (rc == -EPIPE) {
            /* EPIPE means overrun */
            fprintf(stderr, "overrun occurred\n");
            printf("PIPE\n");
            //snd_pcm_prepare(handle);
            //snd_pcm_drop(handle);
            snd_pcm_recover(handle, rc, 0);
            snd_pcm_drain(handle);
        } else if (rc < 0) {
            printf("ERR\n");
            fprintf(stderr,
                    "error from read: %s\n",
                    snd_strerror(rc));
        } else if (rc != (int)frames) {
            printf("SR\n");
            fprintf(stderr, "short read, read %d frames\n", rc);
        }
        
        // write out a file
        rc = write(fout, buffer, size);
        if (rc != size)
            fprintf(stderr,
                    "short write: wrote %d bytes\n", rc);
        ttim[2]= get_time();

        printf("%8d-l%04d:%d frames  %12ld ticks read, %8ld ticks process\n",
               ttim[0],
               loops,
               frames,
               ttim[1] - ttim[0],
               ttim[2] - ttim[1]);
    }

    printf(".end\n");
    close(fout);
  

    printf(".drain\n");
    snd_pcm_drain(handle);
    printf(".pcm_close\n");
    snd_pcm_close(handle);
    printf(".free\n");
    free(buffer);

     snd_output_close(log);
    

    return 0;
}
